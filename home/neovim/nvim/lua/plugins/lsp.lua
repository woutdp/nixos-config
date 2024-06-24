return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    config = function()
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      require("lspconfig").elixirls.setup({ cmd = { "elixir-ls" } })
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").nil_ls.setup({})
      require("lspconfig").nixd.setup({
        cmd = { "nixd" },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            options = {
              nixos = {
                expr = '(builtins.getFlake "/home/wout/.nix").nixosConfigurations.framework.options',
              },
            },
          },
        },
      })
      require("lspconfig").pyright.setup({})
      require("lspconfig").svelte.setup({})
      require("lspconfig").tailwindcss.setup({})
      require("lspconfig").biome.setup({})
    end,
  },
}
