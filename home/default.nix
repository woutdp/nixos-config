{ inputs, lib, config, vars, pkgs, ... }:

{
  imports = [
    ./dunst
    ./git
    ./gtk
    ./hyprland
    ./neovim
    ./shell
    ./waybar
    ./zellij
    ./swappy
    ./fusuma
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
    packages = with pkgs; [
      beeper
      brightnessctl
      coreutils-full
      eww
      fd
      firefox
      google-chrome
      gotop
      grim
      lazygit
      ncdu
      neofetch
      nixfmt
      ollama
      pavucontrol
      ripgrep
      slurp
      spotify
      stylua
      swappy
      swaylock-effects
      telegram-desktop
      vlc
      wl-clipboard
      wofi
      xdotool

      # fonts
      cascadia-code
      dejavu_fonts
      fira-code
      jetbrains-mono
      material-design-icons
      material-icons
      material-symbols
      nerdfonts
      powerline-fonts
      sarasa-gothic
      siji
    ];
    file."code/.keep".text = "";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
