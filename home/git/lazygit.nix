{
  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "always";
        externalDiffCommand = "difft --color=always";
      };
    };
  };
}
