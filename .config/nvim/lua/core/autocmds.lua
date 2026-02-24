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
