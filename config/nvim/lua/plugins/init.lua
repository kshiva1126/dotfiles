return {
  { "folke/lazy.nvim" },
  { "neoclide/coc.nvim", branch = "release" },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")

      require("telescope").setup({})
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<C-S-f>", builtin.live_grep, { desc = "Search in files" })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "coc",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              separator = true,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local api = require("nvim-tree.api")

      local function on_attach(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        local opts = {
          buffer = bufnr,
          desc = "nvim-tree: Open",
          noremap = true,
          silent = true,
          nowait = true,
        }

        -- Open files and directories as buffers with a single mouse click.
        vim.keymap.set("n", "<LeftRelease>", api.node.open.edit, opts)
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            }
          }
        },
        filters = {
          dotfiles = true,
        },
      })
    end
  },
  { "cohama/lexima.vim" },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }
}
