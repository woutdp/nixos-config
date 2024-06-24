{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "center";
        allow_markup = true;
        browser = "${config.programs.google-chrome.package}/bin/google-chrome-stable -new-tab";
        bounce_freq = 0;
        corner_radius = 8;
        dmenu = "${pkgs.wofi}/bin/wofi -dmenu";
        follow = "mouse";
        font = "Fira Code 10";
        format = ''
          <b>%s</b>
          %b
          %p'';
        frame_color = "#555555";
        frame_width = 2;
        geometry = "400-30+30";
        icon_position = "off";
        idle_threshold = 120;
        ignore_newline = false;
        indicate_hidden = true;
        line_height = 0;
        markup = "full";
        max_icon_size = 130;
        horizontal_padding = 15;
        padding = 15;
        separator_color = "frame";
        separator_height = 2;
        show_age_threshold = 60;
        shrink = true;
        sort = true;
        startup_notification = false;
        sticky_history = true;
        transparency = 0;
        word_wrap = true;
      };

      frame = {
        width = 2;
        color = "#83a598";
      };

      urgency_low = {
        frame_color = "#fabd2f";
        background = "#282828";
        foreground = "#ebdbb2";
        timeout = 5;
      };

      urgency_normal = {
        background = "#282828";
        foreground = "#ebdbb2";
        timeout = 15;
      };

      urgency_critical = {
        background = "#282828";
        foreground = "#ebdbb2";
        frame_color = "#CC241D";
        timeout = 0;
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };
    };
  };
}
