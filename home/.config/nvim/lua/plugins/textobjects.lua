return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local swap = require('nvim-treesitter-textobjects.swap')

      -- select: af/if = function, ac/ic = class, aa/ia = argument
      vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
      vim.keymap.set({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)

      -- move: ]f/[f jump between functions, ]c/[c jump between classes
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() move.goto_next_start('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() move.goto_previous_start('@class.outer', 'textobjects') end)

      -- swap: reorder arguments in place
      vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
    end,
  },
}
