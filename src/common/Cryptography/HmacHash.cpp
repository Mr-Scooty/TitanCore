/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#include "HmacHash.h"
#include "BigNumber.h"
#include "Errors.h"
#include <cstring>
#include <openssl/core_names.h>
#include <openssl/params.h>

template<HashCreateFn HashCreator, uint32 DigestLength>
HmacHash<HashCreator, DigestLength>::HmacHash(uint32 len, uint8 const* seed)
{
    EVP_MAC* mac = EVP_MAC_fetch(nullptr, "HMAC", nullptr);
    _ctx = EVP_MAC_CTX_new(mac);
    EVP_MAC_free(mac);

    OSSL_PARAM params[] =
    {
        OSSL_PARAM_construct_utf8_string(OSSL_MAC_PARAM_DIGEST, const_cast<char*>(EVP_MD_get0_name(HashCreator())), 0),
        OSSL_PARAM_construct_end()
    };
    EVP_MAC_init(_ctx, seed, len, params);
    memset(_digest, 0, DigestLength);
}

template<HashCreateFn HashCreator, uint32 DigestLength>
HmacHash<HashCreator, DigestLength>::~HmacHash()
{
    EVP_MAC_CTX_free(_ctx);
}

template<HashCreateFn HashCreator, uint32 DigestLength>
void HmacHash<HashCreator, DigestLength>::UpdateData(std::string const& str)
{
    EVP_MAC_update(_ctx, reinterpret_cast<uint8 const*>(str.c_str()), str.length());
}

template<HashCreateFn HashCreator, uint32 DigestLength>
void HmacHash<HashCreator, DigestLength>::UpdateData(uint8 const* data, size_t len)
{
    EVP_MAC_update(_ctx, data, len);
}

template<HashCreateFn HashCreator, uint32 DigestLength>
void HmacHash<HashCreator, DigestLength>::Finalize()
{
    size_t length = 0;
    EVP_MAC_final(_ctx, _digest, &length, DigestLength);
    ASSERT(length == DigestLength);
}

template<HashCreateFn HashCreator, uint32 DigestLength>
uint8* HmacHash<HashCreator, DigestLength>::ComputeHash(BigNumber* bn)
{
    EVP_MAC_update(_ctx, bn->AsByteArray().get(), bn->GetNumBytes());
    Finalize();
    return _digest;
}

template class TC_COMMON_API HmacHash<EVP_sha1, SHA_DIGEST_LENGTH>;
template class TC_COMMON_API HmacHash<EVP_sha256, SHA256_DIGEST_LENGTH>;
