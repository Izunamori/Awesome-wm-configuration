return {
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
    dashboard.button("n", "> Neovim config", ":e ~/.config/nvim/init.lua<cr>"),
    dashboard.button("c", "> .config", ":e ~/.config/<cr>"),
    dashboard.button("l", "> Lazy", ":Lazy<cr>"),
  }

  alpha.setup(dashboard.config)
  end,
}
