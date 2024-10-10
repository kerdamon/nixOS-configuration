# Configured by hand
This is list of configuration and installed packages done outside of home-manager (mostly because it cannot be done through hm or is not working)

## Packages

- `keyd` - sudo needed
  - `make` - needed for keyd
  - `gcc` - needed for keyd

# Fixes
Fixes and tweaks.

- `zsh`
  - installed and configured through hm, but setting as login shell need sudo
  - path from nix profile was added to `/etc/shells` (valid login shells)
  - chsh was invoked, setting the zsh as login shell

- Lifting AppArmor restrictions
  - in Ubuntu 24.04 by default AppArmor restricts non-root users to use sandboxing in application, so many of apps installed with hm does not work
  - Apps are returning errors: `The SUID sandbox helper binary was found, but is not configured correctly. Rather than run without sandboxing I'm aborting now. You need to make sure that /nix/store/b839r5g9ywf4fkama8zah8r55nwbzmky-electron-31.4.0/libexec/electron/chrome-sandbox is owned by root and has mode 4755.`
  - fix - lift restriction for non-root users 
    - for one session: `sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0`
    - persisting through sessions:
      - add `kernel.apparmor_restrict_unprivileged_userns=0` to `/etc/sysctl.d/<example-filename>.conf`
      - `sudo sysctl -p` or reboot to apply changes 

