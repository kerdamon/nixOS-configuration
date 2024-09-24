# Things done by hand
This is list of configuration and installed packages done outside of home-manager (mostly because it cannot be done through hm or is not working)

- `keyd` - sudo needed
  - `make` - needed for keyd
  - `gcc` - needed for keyd
- `zsh`
  - installed and configured through hm, but setting as login shell need sudo
  - path from nix profile was added to `/etc/shells` (valid login shells)
  - chsh was invoked, setting the zsh as login shell

