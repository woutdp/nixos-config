{ pkgs, ... }:

let
  default = "#d4be98";
  transparent = "#00000000";
in {
  programs.swaylock = {
    enable = true;

    package = pkgs.swaylock-effects;
    settings = {
      # ignore-empty-password = false;
      disable-caps-lock-text = true;
      submit-on-touch = true;
      grace = 1;
      grace-no-mouse = true;

      clock = true;
      timestr = "%R";
      datestr = "%a, %Y %B %e";

      fade-in = "0.2";

      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 14;
      indicator-caps-lock = true;
      indicator-idle-visible = true;

      show-keyboard-layout = false;
      layout-bg-color = transparent;
      layout-text-color = default;

      key-hl-color = "#a9b665cc";
      bs-hl-color = "#7daea3cc";
      caps-lock-key-hl-color = "#7daea3cc";
      caps-lock-bs-hl-color = "#d3869bcc";

      separator-color = transparent;

      inside-color = "#32302f66";
      inside-clear-color = "#89b48266";
      inside-caps-lock-color = "#e78a4e66";
      inside-ver-color = "#7daea366";
      inside-wrong-color = "#ea696266";

      ring-color = "#e78a4ecc";
      ring-clear-color = "#89b482cc";
      ring-caps-lock-color = "#e78a4ecc";
      ring-ver-color = "#7daea3cc";
      ring-wrong-color = "#ea6962cc";

      line-color = transparent;
      line-clear-color = default;
      line-caps-lock-color = default;
      line-ver-color = default;
      line-wrong-color = default;

      text-color = default;
      text-clear-color = default;
      text-caps-lock-color = default;
      text-ver-color = default;
      text-wrong-color = default;

      screenshot = true;
      effect-pixelate = "24";
    };
  };
}
