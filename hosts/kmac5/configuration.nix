{
  self,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./users.nix
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Remove packages not in config
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "zen"
      "raycast"
    ];
  };

  environment.variables = {
    LANG = "pl_PL.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    EDITOR = "vim";
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # metadata - reference flake commit in system generation
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # This is because I am using determinate nix, which manages nix and it conflicts with darwin (see [prerequisites](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#prerequisites))
  nix.enable = false;

  services.tailscale.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      persistent-apps = [ ];
      show-recents = false;
    };
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false; # upon holding key, repeat instead of showing accent menu
      KeyRepeat = 1; # Fastest
      InitialKeyRepeat = 15;
    };
  };
}
