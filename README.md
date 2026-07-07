# LoxBerry Plugin – FHEM

FHEM integration plugin for the LoxBerry home automation platform.

The plugin installs and manages a local FHEM instance on the LoxBerry system and provides access through the LoxBerry web interface.

---

## Features

- Automatic installation of FHEM
- Integration into the LoxBerry Plugin Management
- Starts and manages the FHEM system service
- Migration of older plugin installations
- Integrated WebUI launcher

---

## Compatibility

| Plugin Version | LoxBerry | Debian |
|---------------|----------|---------|
| 0.6.x | 1.x - 3.x | Stretch / Buster / Bullseye |
| 0.7.x | 2.x - 4.x | Bullseye / Bookworm / Trixie |

The plugin has been updated to support current Debian releases while maintaining compatibility with older LoxBerry installations.

---

## Changes in Version 0.7.0

### Fixed

- Replaced deprecated `apt-key` with modern `signed-by` repository handling.
- Switched FHEM repository to HTTPS.
- Improved package installation.
- Improved repository verification.
- Improved service handling.
- Improved migration of existing installations.
- Better error handling during installation.
- Compatible with Debian 12 (Bookworm).
- Compatible with Debian 13 (Trixie).
- Compatible with LoxBerry 2.x, 3.x and 4.x.

---

## Installation

Install the plugin through the LoxBerry Plugin Management.

The installer automatically

- adds the official FHEM repository
- installs all required packages
- installs the FHEM package
- configures the FHEM service
- migrates older plugin installations (if available)

---

## Requirements

- Internet connection
- Supported LoxBerry installation
- Root permissions (handled automatically by LoxBerry)

---

## Troubleshooting

If the installation fails, verify the FHEM repository:

```bash
apt update
apt policy fhem
```

The output should display an available FHEM package.

To verify the repository configuration:

```bash
cat /etc/apt/sources.list.d/fhem.list
```

Expected content:

```text
deb [signed-by=/etc/apt/keyrings/fhem.gpg] https://debian.fhem.de/nightly/ /
```

---

## Project

Original Plugin

Michael Schlenstedt

https://plugins.loxberry.de/

https://www.loxwiki.eu/

---

## License

See the LICENSE file contained in this repository.

---

## Changelog

### Version 0.7.0

- Debian 12 compatibility
- Debian 13 compatibility
- Modern APT repository handling
- HTTPS repository
- Improved installation robustness
- Improved migration handling
- Improved service management

### Version 0.6.1

- Last official release