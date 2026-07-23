return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        end,
      })

      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

      -- nixd ships via nixpkgs (home.nix), not mason, since it isn't in mason's registry
      vim.lsp.enable('nixd')
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'ruff' },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = { 'stylua', 'prettier' },
    },
  },
}
