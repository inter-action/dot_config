-- alias
local opt = vim.opt

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        local minheight = 10
        local maxheight = 30
        local lines = math.max(math.min(vim.fn.line("$"), maxheight), minheight)
        vim.api.nvim_win_set_height(0, lines)
    end
})

-- need to disable telescope's border first
-- vim.o.winborder = 'rounded'

