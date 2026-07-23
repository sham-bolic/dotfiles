return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local langs = { 'lua', 'typescript', 'tsx', 'javascript', 'python', 'nix', 'json', 'markdown' }
      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = langs,
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
