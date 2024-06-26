
---@type LazySpec
return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("silicon").setup({
			-- Configuration here, or leave empty to use defaults
			font = "JetBrainsMono Nerd Font=34",
			theme = "Dracula",
			background = "#483d8b",
			window_title = function()
			  return vim.fn.fnamemodify(
			    vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t"
		    )
		  end
		})
	end
}
