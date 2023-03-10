
local map = vim.api.set
local opts = { noremap=true, silent=true}
local nslicentopts = { noremap=true, silent=false}

-- nvim tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>nf', '<cmd>NvimTreeFindFile<cr>', opts)
map('n', '<leader>nn', '<cmd>NvimTreeToggle<cr>', opts)



-- core
map('n', '<space>z', 
    function()
        vim.api.nvim_command('wa')
        vim.api.nvim_command('stop')
    end,
    opts
)