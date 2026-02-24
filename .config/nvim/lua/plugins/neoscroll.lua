return {
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
}
