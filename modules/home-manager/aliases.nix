{ ... }:
{
  home.shellAliases = {
    "cdt" = "cd ~/tmp";
    "cdd" = "cd ~/Development"; # TODO move to development.nix
    "cdnix" = "cd $MY_NIX_CONF_PATH";

    "cat" = "bat"; # TODO move to terminal-environment.nix
  };
}
