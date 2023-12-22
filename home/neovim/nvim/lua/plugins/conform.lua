return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        -- lua = { "stylua" },
        -- elixir = { "mix format" },
        -- fish = { "fish_indent" },
        -- sh = { "shfmt" },
      },
    },
  },
}
