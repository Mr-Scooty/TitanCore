/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "RSA.h"
#include "BigNumber.h"
#include <openssl/bn.h>
#include <openssl/core_names.h>
#include <openssl/pem.h>
#include <algorithm>
#include <iterator>
#include <memory>
#include <vector>

namespace
{
struct BIODeleter
{
    void operator()(BIO* bio)
    {
        BIO_free(bio);
    }
};

struct PkeyCtxDeleter
{
    void operator()(EVP_PKEY_CTX* ctx)
    {
        EVP_PKEY_CTX_free(ctx);
    }
};

// PEM loading, dispatched on key tag
template <typename KeyTag>
inline EVP_PKEY* ReadPem(BIO* bio);

template <>
inline EVP_PKEY* ReadPem<Trinity::Crypto::RSA::PublicKey>(BIO* bio)
{
    return PEM_read_bio_PUBKEY(bio, nullptr, nullptr, nullptr);
}

template <>
inline EVP_PKEY* ReadPem<Trinity::Crypto::RSA::PrivateKey>(BIO* bio)
{
    return PEM_read_bio_PrivateKey(bio, nullptr, nullptr, nullptr);
}

// RSA_public_encrypt was the raw public-key operation (PKCS#1 type 2 padding),
// RSA_private_encrypt the raw private-key operation (PKCS#1 type 1 padding);
// their EVP equivalents are EVP_PKEY_encrypt and EVP_PKEY_sign respectively.
template <typename KeyTag>
inline int OperationInit(EVP_PKEY_CTX* ctx);

template <>
inline int OperationInit<Trinity::Crypto::RSA::PublicKey>(EVP_PKEY_CTX* ctx)
{
    return EVP_PKEY_encrypt_init(ctx);
}

template <>
inline int OperationInit<Trinity::Crypto::RSA::PrivateKey>(EVP_PKEY_CTX* ctx)
{
    return EVP_PKEY_sign_init(ctx);
}

template <typename KeyTag>
inline int OperationDo(EVP_PKEY_CTX* ctx, unsigned char* out, size_t* outLen, unsigned char const* in, size_t inLen);

template <>
inline int OperationDo<Trinity::Crypto::RSA::PublicKey>(EVP_PKEY_CTX* ctx, unsigned char* out, size_t* outLen, unsigned char const* in, size_t inLen)
{
    return EVP_PKEY_encrypt(ctx, out, outLen, in, inLen);
}

template <>
inline int OperationDo<Trinity::Crypto::RSA::PrivateKey>(EVP_PKEY_CTX* ctx, unsigned char* out, size_t* outLen, unsigned char const* in, size_t inLen)
{
    return EVP_PKEY_sign(ctx, out, outLen, in, inLen);
}
}

Trinity::Crypto::RSA::RSA()
{
    _key = nullptr;
}

Trinity::Crypto::RSA::RSA(RSA&& rsa)
{
    _key = rsa._key;
    rsa._key = nullptr;
}

Trinity::Crypto::RSA::~RSA()
{
    EVP_PKEY_free(_key);
}

template <typename KeyTag>
bool Trinity::Crypto::RSA::LoadFromFile(std::string const& fileName, KeyTag)
{
    std::unique_ptr<BIO, BIODeleter> keyBIO(BIO_new_file(fileName.c_str(), "r"));
    if (!keyBIO)
        return false;

    EVP_PKEY* key = ReadPem<KeyTag>(keyBIO.get());
    if (!key)
        return false;

    EVP_PKEY_free(_key);
    _key = key;
    return true;
}

template <typename KeyTag>
bool Trinity::Crypto::RSA::LoadFromString(std::string const& keyPem, KeyTag)
{
    std::unique_ptr<BIO, BIODeleter> keyBIO(BIO_new_mem_buf(
        const_cast<char*>(keyPem.c_str()) /*api hack - this function assumes memory is readonly but lacks const modifier*/,
        keyPem.length() + 1));
    if (!keyBIO)
        return false;

    EVP_PKEY* key = ReadPem<KeyTag>(keyBIO.get());
    if (!key)
        return false;

    EVP_PKEY_free(_key);
    _key = key;
    return true;
}

BigNumber Trinity::Crypto::RSA::GetModulus() const
{
    BigNumber bn;
    BIGNUM* n = nullptr;
    EVP_PKEY_get_bn_param(_key, OSSL_PKEY_PARAM_RSA_N, &n);
    BN_copy(bn.BN(), n);
    BN_free(n);
    return bn;
}

template <typename KeyTag>
bool Trinity::Crypto::RSA::Encrypt(uint8 const* data, std::size_t dataLength, uint8* output, int32 paddingType)
{
    std::vector<uint8> inputData(std::make_reverse_iterator(data + dataLength), std::make_reverse_iterator(data));

    std::unique_ptr<EVP_PKEY_CTX, PkeyCtxDeleter> ctx(EVP_PKEY_CTX_new(_key, nullptr));
    size_t outputLength = GetOutputSize();
    bool result = ctx
        && OperationInit<KeyTag>(ctx.get()) > 0
        && EVP_PKEY_CTX_set_rsa_padding(ctx.get(), paddingType) > 0
        && OperationDo<KeyTag>(ctx.get(), output, &outputLength, inputData.data(), inputData.size()) > 0;

    std::reverse(output, output + GetOutputSize());
    return result;
}

bool Trinity::Crypto::RSA::Sign(int32 hashType, uint8 const* dataHash, std::size_t dataHashLength, uint8* output)
{
    std::unique_ptr<EVP_PKEY_CTX, PkeyCtxDeleter> ctx(EVP_PKEY_CTX_new(_key, nullptr));
    size_t signatureLength = GetOutputSize();
    bool result = ctx
        && EVP_PKEY_sign_init(ctx.get()) > 0
        && EVP_PKEY_CTX_set_rsa_padding(ctx.get(), RSA_PKCS1_PADDING) > 0
        && EVP_PKEY_CTX_set_signature_md(ctx.get(), EVP_get_digestbynid(hashType)) > 0
        && EVP_PKEY_sign(ctx.get(), output, &signatureLength, dataHash, dataHashLength) > 0;

    std::reverse(output, output + GetOutputSize());
    return result;
}

namespace Trinity
{
namespace Crypto
{
    template TC_COMMON_API bool RSA::LoadFromFile(std::string const& fileName, RSA::PublicKey);
    template TC_COMMON_API bool RSA::LoadFromFile(std::string const& fileName, RSA::PrivateKey);
    template TC_COMMON_API bool RSA::LoadFromString(std::string const& keyPem, RSA::PublicKey);
    template TC_COMMON_API bool RSA::LoadFromString(std::string const& keyPem, RSA::PrivateKey);
    template TC_COMMON_API bool RSA::Encrypt<RSA::PublicKey>(uint8 const* data, std::size_t dataLength, uint8* output, int32 paddingType);
    template TC_COMMON_API bool RSA::Encrypt<RSA::PrivateKey>(uint8 const* data, std::size_t dataLength, uint8* output, int32 paddingType);
}
}
