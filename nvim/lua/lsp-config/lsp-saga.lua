local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup()

local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gd", "<cmd>Lspsaga lsp_finder<CR>")
-- Go to definition
-- keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")


keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Code action
keymap({"n","v"}, "<space>a", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "<space>r", "<cmd>Lspsaga rename<CR>")

-- Show buffer diagnostics
keymap("n", "<space>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n","<space>o", "<cmd>Lspsaga outline<CR>")

-- Call hierarchy
keymap("n", "<space>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<space>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
