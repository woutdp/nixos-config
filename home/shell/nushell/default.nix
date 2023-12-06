{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    shellAliases = {
      ll = "ls -la";
      gst = "git status";
      rebuild = "sudo nixos-rebuild switch --flake /home/wout/.nix ";
      c = "clear";
      gg = "lazygit";
      dev = "nix develop";
    };
  };
}
