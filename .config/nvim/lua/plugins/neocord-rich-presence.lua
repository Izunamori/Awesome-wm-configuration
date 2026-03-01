return {
  "IogaMaster/neocord",
  event = "VeryLazy",  -- загружать лениво
  config = function()
    require("neocord").setup({
      -- здесь твои опции, например:
      main_image = "language",
      show_time = true,
      -- и остальные поля по желанию
    })
  end,
}
