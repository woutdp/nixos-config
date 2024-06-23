return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "biome" },
        elixir = { "mix format" },
        fish = { "fish_indent" },
        javascript = { "prettier" },
        json = { "biome" },
        jsonc = { "biome" },
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
