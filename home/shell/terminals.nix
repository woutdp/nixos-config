{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    settings = {
      font_family = "Cascadia Code";
      font_size = "12";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      resize_debounce_time = "0";
      kitty_mod = "ctrl+alt";
      adjust_line_height = -1;
      adjust_column_width = 0;
      placement_strategy = "top-left";

      # COLORS
      foreground = "#EBDBB2";
      background = "#33332F";
      # black
      color0     = "#282828";
      color8     = "#828374";
      # red
      color1     = "#CC241D";
      color9     = "#FB4934";
      # green
      color2     = "#B8BB26";
      color10    = "#98971A";
      # yellow
      color3     = "#FABD2F";
      color11    = "#D79921";
      # blue
      color4     = "#83A598";
      color12    = "#458588";
      # magenta
      color5     = "#D3869B";
      color13    = "#B16286";
      # cyan
      color6     = "#8EC07C";
      color14    = "#689D6A";
      # white
      color7     = "#EBDBB2";
      color15    = "#A89984";
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
