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
