-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

-- NORMAL --
-- Centering the view after jumps
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "<C-u>", "17<C-u>zz", opts)
keymap("n", "<C-d>", "-17<C-d>zz", opts)

-- INSERT --
-- Press jk or JK fast to escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "JK", "<ESC>", opts)

-- VISUAL --
-- Paste without overwriting the current register
keymap("v", "p", "pgvy", opts)
