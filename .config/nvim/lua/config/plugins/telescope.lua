return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  event = "VimEnter",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- FZF native performance boost
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (vim.fn.executable("cmake") == 1)
          and
          "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
          or "make",
      enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
      config = function(plugin)
        local notify = function(msg, level)
          local ok, noice = pcall(require, "noice")
          if ok then
            noice.api.notify(msg, level)
          else
            vim.notify(msg, level)
          end
        end

        local group = vim.api.nvim_create_augroup("TelescopeFzfNative", { clear = true })
        vim.api.nvim_create_autocmd("User", {
          pattern = "TelescopeLoaded",
          group = group,
          callback = function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir
                  .. "/build/libfzf."
                  .. (vim.loop.os_uname().sysname == "Windows_NT" and "dll" or "so")
              if not vim.uv.fs_stat(lib) then
                notify(
                  "telescope-fzf-native not built. Run :Lazy build telescope-fzf-native.nvim",
                  vim.log.levels.WARN
                )
              else
                notify("Failed to load fzf extension:\n" .. err, vim.log.levels.ERROR)
              end
            end
          end,
        })
      end,
    },

    -- UI Select for better vim.ui.select prompts
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown({}),
            },
          },
        })

        require("telescope").load_extension("ui-select")
      end,
    },
  },

  keys = {
    { "<leader>td", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer diagnostics" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",          desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",           desc = "Grep (live)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",             desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",           desc = "Help Tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",            desc = "Recent Files" },
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
        },
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "dist",
          "build",
          "yarn%.lock",
          "package%-lock%.json",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    vim.api.nvim_exec_autocmds("User", { pattern = "TelescopeLoaded" })
  end,
}
