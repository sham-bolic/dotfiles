return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local langs = { 'lua', 'typescript', 'tsx', 'javascript', 'python', 'nix', 'json', 'markdown', 'html' }
      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'lua',
          'typescript',
          'typescriptreact',
          'tsx',
          'javascript',
          'javascriptreact',
          'python',
          'nix',
          'json',
          'markdown',
          'html',
        },
        callback = function()
          vim.treesitter.start()
          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldenable = false
        end,
      })
    end,
  },
}
