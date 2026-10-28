local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd('FileType', {
    desc = "Autostart treesitter",
    pattern = { '<filetype>' },
    callback = function()
        vim.treesitter.start()
    end,
})


vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Return to last edit position when opening files",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local line = mark[1]
        local ft = vim.bo.filetype
        if
            line > 0
            and line <= lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
            and not vim.o.diff
        then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

