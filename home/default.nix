{ inputs, lib, config, vars, pkgs, ... }:

{
  imports = [
    ./direnv
    ./dunst
    ./git
    ./gtk
    ./hyprland
    ./lock
    ./neovim
    ./shell
    ./swappy
    ./waybar
    ./zellij
    ./wofi
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
      bluez
      brightnessctl
      chromium
      coreutils-full
      dbeaver-bin
      difftastic
      discord
      eww
      fastfetch
      fd
      firefox
      google-chrome
      gotop
      grim
      haskellPackages.git-mediate
      httpie
      kooha
      lapce
      mitmproxy
      mullvad-vpn
      ncdu
      neovide
      netcat-gnu
      ngrok
      nix-your-shell
      nixfmt-classic
      ollama
      pavucontrol
      ripgrep
      slack
      slurp
      spotify
      stylua
      swappy
      swaylock-effects
      telegram-desktop
      vlc
      vscode.fhs
      wl-clipboard
      xdotool
      zoom-us

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
    file.".icons/default".source =
      "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # vscode
  programs.vscode.userSettings."window.titleBarStyle" = "custom";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
