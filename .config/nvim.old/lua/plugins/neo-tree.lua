return {
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

		-- vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "File Explorer" })
	end,
}
