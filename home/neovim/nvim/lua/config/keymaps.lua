-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://ithub.com/LazyVim/LazyVim/blob/main/lua/lazyvim/confi/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
vim.keymap.del("n", "<C-/>")
vim.keymap.set("n", "<C-Return>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.del("t", "<C-/>")
vim.keymap.set("t", "<C-Return>", "<cmd>close<cr>", { desc = "Hide Terminal" })
