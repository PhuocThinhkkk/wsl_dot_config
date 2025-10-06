return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8', -- or use branch = '0.1.x'
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope: Find files' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope: Find git files' })
    vim.keymap.set('n', '<leader>ps', function()
  		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end, { desc = 'Telescope: Grep String' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: Live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Help tags' })
  end
}

