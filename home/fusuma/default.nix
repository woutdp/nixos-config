{ pkgs, ... }:

{
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [
      xdotool
      coreutils-full
    ];
    settings = {
      threshold = {
        swipe = 0.1;
      };
      interval = {
        swipe = 0.7;
      };
      swipe = {
        "3" = {
          left = {
            command = "xdotool key alt+Right";
          };
        };
      };
    };
  };
}
