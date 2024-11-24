#!/usr/bin/env bash
# This script is used to setup my configuration on generic (non-NixOS) linux systems.

NO_ARGS=true
SETUP_CORE=false
SETUP_KEYD=false
SETUP_APPARMOR=false
FIX_DUALBOOT_CLOCK=false

while getopts "hckae" opt; do
  case $opt in
    c)
      NO_ARGS=false
      SETUP_CORE=true
      ;;

    k)
      NO_ARGS=false
      SETUP_KEYD=true
      ;;

    a)
      NO_ARGS=false
      SETUP_APPARMOR=true
      ;;

    d)
      NO_ARGS=false
      FIX_DUALBOOT_CLOCK=true
      ;;

    # everything
    e)
      NO_ARGS=false
      SETUP_CORE=true
      SETUP_KEYD=true
      SETUP_APPARMOR=true
      ;;

    h|\?)
      echo "Use without options to setup defaults. Use -e to setup everything. Use -c to setup only core (nix, home manager). Use -k to setup keyd. Use -a to setup apparmor fix."
      exit 1
      ;;
  esac
done

# defaults
if [[ $NO_ARGS == true ]]; then
  SETUP_CORE=true
  SETUP_KEYD=true
fi

NIX_CONF_PATH="$HOME/Data/nix-conf"
REPO_ADDRESS=https://github.com/kerdamon/nixOS-configuration.git

if [[ $SETUP_CORE == true ]]; then
  echo "Setting up nix and home-manager"

  # setup nix
  sh <(curl -L https://nixos.org/nix/install) --daemon
  sudo bash -c " echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf"
  source /etc/profile # TODO check if it works. Should make nix available in this shell session

  # setup home manager
  nix run home-manager/master -- init --switch $NIX_CONF_PATH
  rm -rf $NIX_CONF_PATH
  git clone $REPO_ADDRESS $NIX_CONF_PATH
  bash -c "home-manager switch --flake $NIX_CONF_PATH#generic-linux"

  # allow unfree for nix-shell, nix-env and nix-build
  mkdir -p ~/.config/nixpkgs && echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix # TODO check if works

  # set zsh as default shell
  ZSH_PATH=$(which zsh)
  sudo bash -c "echo $ZSH_PATH >> /etc/shells"
  chsh -s $(which zsh)

  echo "Nix and home-manager setup complete. Default shell switched to zsh, system restart required. HM switched to generic linux, remember to add new config for this device in $NIX_CONF_PATH."
fi

if [[ $SETUP_KEYD == true ]]; then
  echo "Setting up keyd"
  git clone https://github.com/rvaiya/keyd $HOME/tmp/keyd
  nix-shell -p gnumake libgcc --run "make -C $HOME/tmp/keyd && sudo make -C $HOME/tmp/keyd install"
  sudo systemctl enable keyd && sudo systemctl start keyd
  sudo mkdir -p /etc/keyd
  sudo cp $NIX_CONF_PATH/dotfiles/keyd.conf /etc/keyd/default.conf
  sudo keyd reload
  echo "Keyd setup complete"
fi

if [[ $FIX_DUALBOOT_CLOCK = true ]]; then # TODO check if it works
  echo "Setting up dualboot BIOS clock fix - setting linux to use local time"
  sudo timedatectl set-local-rtc 1 # to revert: sudo timedatectl set-local-rtc 0
fi

if [[ $SETUP_APPARMOR == true ]]; then
  echo "Setting up apparmor fix"
  sudo bash -c " echo 'kernel.apparmor_restrict_unprivileged_userns=0' >> /etc/sysctl.d/apparmor-fix.conf"
  sudo sysctl -p
  echo "Apparmor fix complete"
fi

