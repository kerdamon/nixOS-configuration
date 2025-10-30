{ ... }:

{
  programs.git = {
    enable = true;
    userName = "kerdamon";
    userEmail = "kwalas314@gmail.com";
    delta.enable = true; # program for nice diff visualisation. Also used in fzf-tab previews.
  };
}