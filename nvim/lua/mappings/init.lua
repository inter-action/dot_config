
local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true}
local nslicentopts = { noremap=true, silent=false}

map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- nvim tree

map('n', '<leader>nf', '<cmd>NvimTreeFindFile<cr>', opts)
map('n', '<leader>nn', '<cmd>NvimTreeToggle<cr>', opts)


