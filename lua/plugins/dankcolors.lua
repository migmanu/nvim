return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#2a2a2a',
				base01 = '#2a2a2a',
				base02 = '#6e6f71',
				base03 = '#6e6f71',
				base04 = '#222223',
				base05 = '#bbbcbf',
				base06 = '#bbbcbf',
				base07 = '#bbbcbf',
				base08 = '#b26377',
				base09 = '#b26377',
				base0A = '#747a8c',
				base0B = '#3f8c4a',
				base0C = '#42464e',
				base0D = '#747a8c',
				base0E = '#60636a',
				base0F = '#60636a',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#6e6f71',
				fg = '#bbbcbf',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#747a8c',
				fg = '#2a2a2a',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6e6f71' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#42464e', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#60636a',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#747a8c',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#747a8c',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#42464e',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#3f8c4a',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#222223' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#222223' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#6e6f71',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
