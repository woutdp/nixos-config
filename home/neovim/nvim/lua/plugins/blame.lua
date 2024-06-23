return {
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup({
        date_format = "%Y %b %d",
      })
    end,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Git Blame" },
    },
  },
}
