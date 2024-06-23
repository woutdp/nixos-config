{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
  };

  home.packages = with pkgs; [
    (writers.writePython3Bin "mediaplayer" {
      libraries = with pkgs.python3Packages; [
        pygobject3
        glib
        gobject-introspection
      ];
      flakeIgnore = [
        "E501"
        "W503"
      ];
    } (builtins.readFile ./mediaplayer.py))
  ];

  home.file.".config/waybar/config".source = ./config.jsonc;
  home.file.".config/waybar/scripts/mediaplayer.sh".source = ./mediaplayer.sh;
  home.file.".config/waybar/style.css".source = ./style.css;
}
