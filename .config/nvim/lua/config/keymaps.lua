vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer", silent = true })
map("n", "<leader>er", "<cmd>Neotree reveal<cr>", { desc = "Reveal file in Neotree", silent = true })

map("i", "jj", "<Escape>", { silent = true, noremap = true })

-- Easy navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Move to right window" })
map("n", "<leader>l", ":Lazy<CR>", { silent = true, desc = "Show Lazy status" })

-- Toggle search highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
