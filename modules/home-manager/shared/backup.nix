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

  home.file = {
    "Backup/.keep".text = "";
  };
}
