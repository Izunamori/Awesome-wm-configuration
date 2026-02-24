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

vim.keymap.set("n", "<leader>sd", function()
  require("snacks.dashboard").open()
end, { desc = "Open Snacks Dashboard" })

vim.keymap.set("n", "<leader>m", "<cmd>Alpha<cr>", { desc = "Show dashboard" })

vim.keymap.set("n", "<leader>c", "<cmd>gc<cr>", { desc = "comment" })


