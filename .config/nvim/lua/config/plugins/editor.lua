return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin" },
        -- options = { theme = "base2tone_desert_dark" },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<S-l>",   "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer",      silent = true },
      { "<A-S-l>", "<cmd>BufferLineMoveNext<cr>",  desc = "Move next buffer", silent = true },
      { "<S-h>",   "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer",      silent = true },
      { "<A-S-h>", "<cmd>BufferLineMovePrev<cr>",  desc = "Move prev buffer", silent = true },
      {
        "<A-S-p>",
        "<cmd>BufferLineTogglePin<cr>",
        desc = "Toggle pinned buffer",
        silent = true,
      },
      { "<S-x>",      "<cmd>bp|bd#<cr>",              desc = "Close buffer no window",        silent = true },
      { "<leader>x",  "<cmd>bd<cr>",                  desc = "Close buffer and window",       silent = true },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all buffers to the left", silent = true },
      {
        "<leader>br",
        "<cmd>BufferLineCloseRight<cr>",
        desc = "Close all buffers to the right",
        silent = true,
      },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        always_show_bufferline = true,
        offset = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>gb",
        "<cmd>Gitsigns toggle_current_line_blame<cr>",
        desc = "GIT toggle line blame",
        silent = true,
      },
    },
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gs", "<cmd>G<cr>",             desc = "GIT Fugitive status", silent = true },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",  desc = "Open GIT diff view",  silent = true },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close GIT diff view", silent = true },
    },
    config = function()
      require("diffview").setup()
    end,
  },
}
