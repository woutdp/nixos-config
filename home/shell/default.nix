{
  imports = [ ./fish ./starship.nix ./terminals.nix ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    DEFAULT_BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
    TERM = "kitty";
    VISUAL = "nvim";
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
  };
}
