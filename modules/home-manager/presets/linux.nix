# This file contains Home Manager configuration specific to Linux systems
# TODO move generic stuff to base and workstation stuff to workstation and make conditionals for linux specific only

{ lib, pkgs, ... }:
{
  home.stateVersion = "24.05"; # TODO update?
  targets.genericLinux.enable = lib.mkIf (
    pkgs.stdenv.hostPlatform.isLinux
    && pkgs.stdenv.hostPlatform.isx86_64
    && !pkgs.stdenv.hostPlatform.isNixOS
  ) true; # For some reason does not work on aarch64. TODO investigate further if this would be beneficial to have on raspberry pi as well
}
