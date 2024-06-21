{
  # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
  # wayland.windowManager.hyprland.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
