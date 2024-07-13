return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "biome" },
        html = { "biome" },
        svg = { "biome" },
        elixir = { "mix format" },
        fish = { "fish_indent" },
        javascript = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        python = { "black" },
        sh = { "shfmt" },
        svelte = { "prettier" },
        typescript = { "prettier" },
      },
    },
  },
}
