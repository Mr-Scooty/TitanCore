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

// note: do not reuse OpenSSL's own OPENSSL_CRYPTO_H include guard
#ifndef OpenSSLCrypto_h__
#define OpenSSLCrypto_h__

#include "Define.h"

/**
* Global one-time setup/teardown of the OpenSSL library.
* OpenSSL 1.1+ is thread-safe out of the box; this now only loads the
* providers needed by the core (the game protocol requires RC4, which
* lives in the OpenSSL 3.x "legacy" provider).
*/
namespace OpenSSLCrypto
{
    /// Needs to be called before threads using openssl are spawned
    TC_COMMON_API void threadsSetup();
    /// Needs to be called after threads using openssl are despawned
    TC_COMMON_API void threadsCleanup();
}

#endif
