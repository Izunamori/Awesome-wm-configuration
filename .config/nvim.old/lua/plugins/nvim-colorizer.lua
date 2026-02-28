return {
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
}
