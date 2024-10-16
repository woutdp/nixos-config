vim.opt.number = false
vim.opt.relativenumber = false

vim.o.guifont = "Cascadia Code:h10:w-1"

-- neovide
vim.g.neovide_scroll_animation_length = 0.05
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scale_factor = 1.1
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.10)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.10)
end)
