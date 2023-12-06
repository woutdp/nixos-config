{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/mediaplayer.py".source = ./mediaplayer.py;
  home.file.".config/waybar/style.css".source = ./style.css;
}
