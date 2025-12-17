# This file contains Home Manager configuration specific to Linux systems
# TODO move generic stuff to base and workstation stuff to workstation and make conditionals for linux specific only

{ ... }:
{
  home.stateVersion = "24.05"; # TODO update?
  targets.genericLinux.enable = true;
}
