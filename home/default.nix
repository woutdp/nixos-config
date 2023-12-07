{ inputs, lib, config, vars, pkgs, ... }:

{
  imports = [ ./git ./gtk ./hyprland ./neovim ./shell ./waybar ./zellij ];

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
      eww
      fd
      google-chrome
      gotop
      lazygit
      ncdu
      neofetch
      nixfmt
      pavucontrol
      ripgrep
      spotify
      stylua
      swaylock-effects
      telegram-desktop
      unzip
      vlc
      wl-clipboard
      wofi

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
  };

  fonts.fontconfig.enable = true;

  home.file."code/.keep".text = "";

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
