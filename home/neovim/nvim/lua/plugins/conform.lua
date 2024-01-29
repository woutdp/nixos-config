return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        -- elixir = { "mix format" },
        -- lua = { "stylua" },
        -- fish = { "fish_indent" },
        -- sh = { "shfmt" },
      },
    },
  },
}
