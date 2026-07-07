# Contributing

Thank you for your interest in improving this plugin.

## Goal

Keep the plugin compatible with current and future LoxBerry releases while maintaining compatibility with existing installations whenever possible.

---

## Coding Style

### Shell Scripts

- Use POSIX compatible shell where possible.
- Quote variables.
- Use meaningful log messages.
- Check return codes.
- Avoid deprecated commands.

Example:

```bash
if ! apt-get update; then
    echo "<ERROR> apt update failed."
    exit 1
fi
```

---

## Compatibility

Please try to keep compatibility with

- LoxBerry 2.x
- LoxBerry 3.x
- LoxBerry 4.x

unless a change explicitly requires dropping support.

---

## Pull Requests

Please keep pull requests focused.

Typical improvements include

- Bug fixes
- Debian compatibility
- Security improvements
- Documentation
- Installation improvements

---

## Testing

Before submitting changes, please verify

- Plugin installation
- Plugin update
- Fresh installation
- Upgrade from older plugin versions
- FHEM service starts correctly
- Repository configuration works
- Package installation succeeds

---

## Reporting Issues

Please include

- LoxBerry version
- Debian version
- Raspberry Pi model (or other hardware)
- Complete installation log
- Relevant system logs

---

## Credits

Original plugin

Michael Schlenstedt

Community maintenance and compatibility improvements are welcome.