vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

-- Rounded borders for LSP hover and signature help
local lsp = vim.lsp
local handlers = lsp.handlers

handlers["textDocument/hover"] = lsp.with(handlers.hover, {
  border = "rounded",
  focusable = false,
  close_events = { "CursorMove", "InsertLeave", "BufHide", "BufLeave" },
})

handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, {
  border = "rounded",
  focusable = false,
  close_events = { "CursorMove", "InsertLeave", "BufHide", "BufLeave" },
})

vim.diagnostic.config({
  float = {
    border = "rounded",
    focusable = false,
  },
})
