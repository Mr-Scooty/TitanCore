---
# TitanCore
---

## Introduction

TitanCore is an open-source game server application and framework designed for hosting massively multiplayer online role-playing games (MMORPGs), and it is based on the popular MMORPG, World of Warcraft (WoW) and seeks to recreate the gameplay experience of the Legion expansion. 

The original code is based on [TrinityCore](https://github.com/TrinityCore/TrinityCore), and this project serves as a continuation of [TrinityCore's](https://github.com/TrinityCore/TrinityCore) work up to game patch 7.3.5.

## Short-term Goals

[TrinityCore's](https://github.com/TrinityCore/TrinityCore) last commit to the [7.3.5](https://github.com/TrinityCore/TrinityCore/tree/7.3.5/26972) tag was made in 2018. Substantial work remains to be undertaken to update the codebase, ensuring it compiles correctly on modern systems.

- [x] Add support for Boost >= 1.71
- [x] Add support for MySQL 8
- [ ] Add support for OpenSSL 3.x
- [ ] Remove support for OpenSSL 1.x
- [ ] Patch game client so it connects to the game server*

*Game patching also needs to function effectively on Unix-like operating systems, in addition to Windows systems.

## Long-term Goals

Adoption of the [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk) philosophy.

*Our main goal is to create a playable game server, offering a fully working in-game experience.*

*Here are the main points we focus on:*

- *Stability*
    - *We make sure all changes pass the CIs before being merged into the master branch.*

- *Blizzlike content*
    - *We strive to make all in-game content to be blizzlike. Therefore we have a high standard of fixes being made.*

- *Customization*
    - *It is easy to customize your experience using modules.*

- *Community driven*
    - *AzerothCore has an active community of developers, contributors, and users who collaborate, share knowledge, and provide support through forums, Discord channels, and other communication platforms.*

## Installation

Currently, the project compiles on Ubuntu 20.04 LTS; however, it is not recommended to use this version until support for OpenSSL 3.x is added.

Detailed installation instructions will be provided at a later date.

## Contributing

Fixes are submitted as pull request through GitHub.

## Reporting Issues

Issues can be reported through GitHub's issue tracker. 

## Authors & Contributors

Read file [THANKS](THANKS).

## License

- TitanCore's source components are released under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html)
- The old sources based on MaNGOS/TrinityCore are released under the [GNU GPL v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

It's important to note that TitanCore is not an official Blizzard Entertainment product, and it is not affiliated with or endorsed by World of Warcraft or Blizzard Entertainment. TitanCore does not, in any case, sponsor nor support illegal public servers. If you use this project to run an illegal public server, rather than for testing and learning, it is your own personal choice.