-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://ithub.com/LazyVim/LazyVim/blob/main/lua/lazyvim/confi/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { silent = true })

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
keymap.del("n", "<C-/>")
keymap.set("n", "<C-Return>", lazyterm, { desc = "Terminal (root dir)" })
keymap.del("t", "<C-/>")
keymap.set("t", "<C-Return>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Don't copy single character deletion to clipboard
keymap.set("n", "x", '"_x')

-- Increment/Decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
