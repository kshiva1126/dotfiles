return {
  { "folke/lazy.nvim" },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  { "neoclide/coc.nvim", branch = "release" },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function ()
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            }
          }
        }
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
