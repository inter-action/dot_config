
local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true}
local nslicentopts = { noremap=true, silent=false}

map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)


-- telescope bindings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

map('n', '<leader>fa', '<cmd>Telescope builtin<cr>', opts)



