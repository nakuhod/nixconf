-- -- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        'nvim-treesitter/nvim-treesitter',
        -- optional
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key",
                    },

                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    file_ignore_patterns = { "node_modules", ".git", ".venv" },
                    hidden = true,
                },

                buffers = {
                    initial_mode = "insert",
                    sort_lastused = true,
                },

                man_pages = {
                    sections = { "ALL" },
                },
            },
            live_grep = {
                file_ignore_patterns = { "node_modules", ".git", ".venv" },

                additional_args = function(_)
                    return { "--hidden" }
                end,
            },
            path_display = {
                filename_first = {
                    reverse_directories = true,
                },
            },

            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            git_files = {
                previewer = false,
            },
        })

        -- Enable telescope fzf native, if installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")


        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })
        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search [G]it [B]ranches" })
        vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search [G]it [C]ommits" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Search [G]it [S]tatus (diff view)" })
        vim.keymap.set("n", "<leader>rg", builtin.registers, { desc = "[S]earch [R]egisters" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [M]an pages" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "[S]earch [M]arks" })

        vim.keymap.set("n", "<leader>/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "List references for the word under the cursor" })
        vim.keymap.set("n", "<leader>d", builtin.diagnostics,
            { desc = "List diagnostics for all open buffers" })

        vim.keymap.set("n", "<leader>D", function()
            builtin.diagnostics({
                bufnr = 0,
                prompt_title = "Diagnostics for the current buffer",
            })
        end, { desc = "List diagnostics for the current buffer" })
    end,
}
