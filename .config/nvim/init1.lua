----- bootstrap lazy.nvim -----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----- Lazy setup -----
require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({})
    end,
  },
  {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({})
  end,
  },
  {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*" ,     
      css = { rgb_fn = true },
      html = { names = false },
    }, {
      mode = "background",
      rgb_fn = true,
      css = true,
    })
  end,
  },
  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",      
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true, 
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
  },
  {
  "Mofiqul/vscode.nvim",
  config = function()
    require("vscode").setup({
      style = "dark",         
      transparent = true,    
      italic_comments = true, 
      disable_nvimtree_bg = true,
    })
    vim.cmd([[colorscheme vscode]])
  end,
  }
})

