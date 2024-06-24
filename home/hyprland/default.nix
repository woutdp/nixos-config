{
  # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
  # wayland.windowManager.hyprland.enable = true;
  home.file = {
    ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };
}
