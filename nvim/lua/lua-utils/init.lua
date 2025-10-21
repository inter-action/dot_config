local M = {}


-- Function to retrieve and display the current cursor position
function M.move_cursor_next()

  -- Get the current cursor position in the current window
  local current_win_id = 0
  local cursor_pos = vim.api.nvim_win_get_cursor(current_win_id)
  local line = cursor_pos[1] -- 1-based line number
  local col = cursor_pos[2] -- 0-based column number

  -- Display the cursor position in the command line
  -- print("Cursor Position: Line " .. line .. ", Column " .. col)
  vim.api.nvim_win_set_cursor(current_win_id, {line, col + 1})
end


function M.get_buffer_relative_filename()
    -- return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. '/', '')
    return vim.fn.expand('%')
end


function M.merge2(a, b)
    -- return vim.tbl_extend("force", unpack(arg))
    --                                       ^ arg is not working inside neovim
    return vim.tbl_extend("force", a, b)
end


-- Functional wrapper for mapping custom keybindings
function M.map_command(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if type(opts) == "table" then
        options = vim.tbl_extend("force", options, opts)
    elseif type(opts) == "string" then
        options = vim.tbl_extend("force", options, {
            desc = opts
        })
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.map_func(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if type(opts) == "table" then
        options = vim.tbl_extend("force", options, opts)
    elseif type(opts) == "string" then
        options = vim.tbl_extend("force", options, {
            desc = opts
        })
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

-- using nvim_feedkeys to simulate user's input
local function move_cursor_up(lines)
  vim.api.nvim_feedkeys(tostring(lines) .. "k", "n", false)
end

-- Example usage: Move the cursor up by 5 lines
-- vim.keymap.set('n', '<leader>k', function()
--   move_cursor_up(5)
-- end, { desc = "Move cursor up by 5 lines" })




-- export exports
return M