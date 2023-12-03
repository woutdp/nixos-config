{ inputs, lib, config, vars, pkgs, ... }: 

{
  imports = [
    ./git
    ./gnupg
    ./gtk
    ./hyprland
    ./neovim
    ./shell
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
  };

  home.file."code/.keep".text = "";
      
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
