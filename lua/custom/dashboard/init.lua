return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom', -- Or another preferred theme
        config = {
          header = {
            '           ▄ ▄                   ',
            '       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ',
            '       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ',
            '    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ',
            '  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ',
            '  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄',
            '▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █',
            '█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █',
            '    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ',
          },
          buttons = {
            { '  Find File', 'Spc f f', ':Telescope find_files<CR>' },
            { '󰈚  Recent Files', 'Spc f o', ':Telescope oldfiles<CR>' },
            { '󰈭  Find Word', 'Spc f w', ':Telescope live_grep<CR>' },
            { '  Bookmarks', 'Spc m a', ':Telescope marks<CR>' },
            { '  Themes', 'Spc t h', ':Telescope themes<CR>' },
            { '  Mappings', 'Spc c h', ':NvCheatsheet<CR>' },
          },
          footer = { 'Mohamed Cusomization' },
        },
      }
    end,
  },
}
