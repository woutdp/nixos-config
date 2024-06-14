{ config, pkgs, lib, ... }:

let destinationDir = "${config.home.homeDirectory}/.config/nvim";
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.activation.changePermissions =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      chmod -R u+w ${destinationDir}
    '';
}
