{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "always";
        useConfig = true;
        externalDiffCommand = "difft --color=always";
      };
    };
  };
}
