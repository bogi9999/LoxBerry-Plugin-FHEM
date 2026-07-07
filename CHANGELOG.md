# Changelog

Project Homepage:
https://github.com/DEINNAME/LoxBerry-Plugin-FHEM

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog:
https://keepachangelog.com/en/1.1.0/

---

## [0.7.0] - 2026-07-07

### Added
- Support for Debian 12 (Bookworm)
- Support for Debian 13 (Trixie)
- Improved compatibility with LoxBerry 2.x, 3.x and 4.x
- Modern APT repository configuration using keyrings
- HTTPS support for the FHEM package repository

### Changed
- Replaced deprecated `apt-key` with `signed-by`
- Improved installation scripts
- Improved migration of existing installations
- Improved service handling
- Improved installation logging
- Improved error handling

### Fixed
- Installation failure on Debian 13
- Repository signature verification
- Missing FHEM package during installation
- Better detection of failed installations
- Various shell script improvements

---

## [0.6.1]

Last official release.
