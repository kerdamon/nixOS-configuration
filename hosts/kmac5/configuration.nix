{ pkgs, self, nixpkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./users.nix
  ];

  environment.systemPackages = with pkgs; [];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Remove packages not in config
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "zen"
    ];
    brews = [];
  };

  environment.variables = {
    LANG = "pl_PL.UTF-8";
    LC_MESSAGES="en_US.UTF-8";
    EDITOR = "vim";
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # This is becouse I am using determinate nix, which manages nix and it conflicts with darwin (see [prerequisities](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#prerequisites))
  nix.enable = false;

  services.tailscale.enable = true;
}
