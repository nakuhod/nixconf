return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.header.val = {
            [[                                   ]],
            [[                                   ]],
            [[                                   ]],
            [[                                   ]],
            [[                                   ]],
            [[                                   ]],
            [[                                   ]],
            [[                       _           ]],
            [[                      (_)          ]],
            [[ _ __   ___  _____   ___ _ __ ___  ]],
            [[| '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
            [[| | | |  __/ (_) \ V /| | | | | | |]],
            [[|_| |_|\___|\___/ \_/ |_|_| |_| |_|]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "󰍉  Find file", ":Telescope find_files<CR>"),
            dashboard.button("g", "  Grep pwd", ":Telescope live_grep<CR>"),
            dashboard.button("m", "󰈙  Man pages", ":Telescope man_pages<CR>"),
            dashboard.button("r", "󱝏  MRU files", ":Telescope oldfiles<CR>"),
            dashboard.button("o", "  Browse pwd", ":edit .<CR>"),
            dashboard.button("c", "  Browse nixconf", ":edit $HOME/nixconf <CR>"),
            dashboard.button("d", "  Browse dotfiles", ":edit $HOME/nixconf/dotfiles <CR>"),
            dashboard.button("n", "  Browse neovim config", ":edit $HOME/nixconf/dotfiles/nvim <CR>"),
            dashboard.button("l", "  Plugins", ":Lazy<CR>"),
            dashboard.button("q", "󰅙  Quit", ":q!<CR>"),
        }

        dashboard.section.footer.val = function()
            return "  "
        end

        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.config.opts.position = "center"
        dashboard.config.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end
};
