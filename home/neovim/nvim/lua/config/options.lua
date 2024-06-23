-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = false
vim.opt.relativenumber = false

-- Neovide
vim.o.guifont = "Cascadia Code:h10:w-1"
vim.g.neovide_scroll_animation_length = 0.15
vim.g.neovide_hide_mouse_when_typing = true

-- vim.g.neovide_font_hinting = 'none'
-- vim.g.neovide_font_edging = 'subpixelantialias'
-- vim.g.neovide_cursor_animation_length = 0

vim.g.neovide_scale_factor = 1.2
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.10)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.10)
end)
