return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      -- Keep blink.cmp in control of <CR> while retaining bracket pairing.
      map_cr = false,
      -- Typing an existing closing bracket moves past it instead of duplicating it.
      enable_moveright = true,
    },
  },
}
