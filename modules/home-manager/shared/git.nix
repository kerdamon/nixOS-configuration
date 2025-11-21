{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "kerdamon";
      email = "kwalas314@gmail.com";
    };
  };

  # program for nice diff visualisation. Also used in fzf-tab previews.
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}