vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2

vim.api.nvim_create_user_command("Tab", function(opts)
  local n = tonumber(opts.args)
  if not n then return end

  local path = vim.fn.stdpath("config") .. "/init.lua"
  local lines = vim.fn.readfile(path)

  for i, line in ipairs(lines) do
    if line:match("^%s*vim%.opt%.shiftwidth%s*=") then
      lines[i] = "vim.opt.shiftwidth = " .. n
      break
    end
  end

  vim.fn.writefile(lines, path)
end, { nargs = 1 })

-- bootstrap lazy.nvim
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
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          hijack_netrw_behavior = "open_default",
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
          },
        },
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local arg = vim.fn.argv(0)
          if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("enew")
            require("neo-tree.command").execute({
              action = "show",
              source = "filesystem",
              position = "left",
              dir = arg,
            })
          end
        end,
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "File Explorer" })
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
    'numToStr/Comment.nvim',
    lazy = false,  
    opts = {
        padding = true,
        sticky = true,
        ignore = nil,
    },
  },
  {
    "lambdalisue/vim-suda",
    config = function()
      vim.g.suda_smart_edit = 1
    end
  },  
  {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      easing_function = "cubic",  
      hide_cursor = true,
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
    })


  end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",

    config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
	    "Neovim",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "> Find file", ":Telescope find_files<cr>"),
      dashboard.button("r", "> Recent files", ":Telescope oldfiles<cr>"),
      dashboard.button("a", "> Awesome config", ":e ~/.config/awesome<cr>"),
      dashboard.button("nv", "> Neovim config", ":e ~/.config/nvim/init.lua<cr>"),
      dashboard.button("c", "> .config", ":e ~/.config/<cr>"),
      dashboard.button("l", "> Lazy", ":Lazy<cr>"),

    }

    alpha.setup(dashboard.config)
    end,
  },
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

--- binds ---

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Open Neo-tree" })

vim.keymap.set("n", "<S-l>", ":bnext<CR>")

vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

vim.keymap.set("n", "<leader>x>", ":bd<CR>")

vim.keymap.set("n", "<S-x>", function()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs == 1 then
    vim.cmd("enew")
  else
    for _, buf in ipairs(bufs) do
      if buf.bufnr ~= current then
        vim.api.nvim_set_current_buf(buf.bufnr)
        break
      end
    end
  end
  vim.cmd("bdelete " .. current)
end, { desc = "Close current buffer safely" })

vim.keymap.set("n", "<leader>o", function()
  local handle = io.popen("gtk-file-chooser-dialog --select-folder")
  local result = handle:read("*a")
  handle:close()
  if result ~= "" then
    require("neo-tree.command").execute({
      action = "show",
      source = "filesystem",
      position = "left",
      dir = result:gsub("%s+$", ""),
    })
  end
end, { desc = "Open folder via GTK portal" })

vim.keymap.set("n", "<leader>sd", function()
  require("snacks.dashboard").open()
end, { desc = "Open Snacks Dashboard" })

vim.keymap.set("n", "<leader>m", "<cmd>Alpha<cr>", { desc = "Show dashboard" })

vim.keymap.set("n", "<leader>c", "<cmd>gc<cr>", { desc = "comment" })




