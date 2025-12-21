{ pkgs, ... }:
{
  home.packages = with pkgs; [
    borgbackup
    borgmatic
  ];
  services.borgmatic = {
    enable = true;
    frequency = "daily";
  };
  # TODO create Backup folder in home.file
}
