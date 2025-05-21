vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle File Explorer", silent = true })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files", silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep", silent = true })
map("i", "jj", "<Escape>", { silent = true, noremap = true })

-- Easy navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Move to right window" })
map("n", "<leader>l", ":Lazy<CR>", { silent = true, desc = "Show Lazy status" })

-- Show buffer diagnostics
map("n", "<leader>td", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer diagnostics" })

-- Toggle search highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
