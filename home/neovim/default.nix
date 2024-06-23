# https://github.com/water-sucks/nixed/blob/main/home/profiles/base/nvim/default.nix
{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      # Language Servers
      # https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      elixir
      elixir_ls
      # inputs.next-ls
      # vimPlugins.elixir-tools-nvim
      lua-language-server
      nil
      nodePackages_latest.svelte-language-server
      pyright
      pkgs.nodePackages."@tailwindcss/language-server"

      # Formatters
      # https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
      black
      elixir
      nixfmt-rfc-style
      nodePackages.prettier
      biome
      shfmt
      stylelint
      stylua
    ];
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
