return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        python = { 'ruff_format' },
        nix = { 'alejandra' },
      },
      format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' },
    },
  },
}
