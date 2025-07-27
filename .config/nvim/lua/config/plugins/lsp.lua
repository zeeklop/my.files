return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", config = true },
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local servers = { "ts_ls", "jdtls", "lua_ls", "eslint" }

      -- Setup Mason
      mason.setup()
      mason_lspconfig.setup({
        automatic_enable = false,
        ensure_installed = servers,
      })

      -- Define on_attach
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>ld", vim.lsp.buf.definition, "Go to definition")
        nmap("<leader>lD", vim.lsp.buf.declaration, "Go to declaration")
        nmap("<leader>li", vim.lsp.buf.implementation, "Go to implementation")
        nmap("<leader>lr", function()
          require("telescope.builtin").lsp_references()
        end, "Go to references")
        nmap("<leader>lk", vim.lsp.buf.hover, "Show documentation")
        nmap("<leader>lR", vim.lsp.buf.rename, "Rename symbol")
        nmap("<leader>la", function()
          vim.lsp.buf.code_action({ apply = true })
        end, "Code action")
        nmap("<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
        nmap("<leader>d", function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end, "Show line disagnostics")

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
          desc = "Format buffer before saving",
        })
      end

      -- LSP capabilities with cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup each LSP server
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expando_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
