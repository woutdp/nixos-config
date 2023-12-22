{
  imports = [ ./fish ./starship.nix ./terminals.nix ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
    VISUAL = "nvim";
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
  };
}
