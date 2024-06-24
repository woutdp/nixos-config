{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    settings = {
      font_family = "Cascadia Code";
      font_size = "10.8";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      resize_debounce_time = "0";
      kitty_mod = "ctrl+alt";
      adjust_line_height = 0;
      adjust_column_width = 0;
      placement_strategy = "top-left";

      cursor_blink_interval = 0;
      cursor = "#928374";
      cursor_text_color = "background";

      url_color = "#83a598";

      visual_bell_color = "#8ec07c";
      bell_border_color = "#8ec07c";

      active_border_color = "#d3869b";
      inactive_border_color = "#665c54";

      foreground = "#ebdbb2";
      background = "#1d2021";
      selection_foreground = "#928374";
      selection_background = "#ebdbb2";

      active_tab_foreground = "#fbf1c7";
      active_tab_background = "#665c54";
      inactive_tab_foreground = "#a89984";
      inactive_tab_background = "#3c3836";

      color0 = "#665c54"; # black (bg3/bg4)
      color8 = "#7c6f64";

      color1 = "#cc241d"; # red
      color9 = "#fb4934";

      color2 = "#98971a"; # green
      color10 = "#b8bb26";

      color3 = "#d79921"; # yellow
      color11 = "#fabd2f";

      color4 = "#458588"; # blue
      color12 = "#83a598";

      color5 = "#b16286"; # purple
      color13 = "#d3869b";

      color6 = "#689d6a"; # aqua
      color14 = "#8ec07c";

      color7 = "#a89984"; # white (fg4/fg3)
      color15 = "#bdae93";
    };
    keybindings = {
      "kitty_mod+RIGHT_BRACKET" = "change_font_size all +0.1";
      "kitty_mod+LEFT_BRACKET" = "change_font_size all -0.1";
      "kitty_mod+0" = "change_font_size all 0";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
