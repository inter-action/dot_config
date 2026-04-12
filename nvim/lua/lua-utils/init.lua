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
    vim.api.nvim_win_set_cursor(current_win_id, { line, col + 1 })
end

function M.get_buffer_relative_filename()
    -- return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. '/', '')
    return vim.fn.expand('%')
end

function M.extends(...)
    return vim.tbl_extend('force', ...)
end

-- Functional wrapper for mapping custom keybindings
function M.map_command(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if type(opts) == 'table' then
        options = vim.tbl_extend('force', options, opts)
    elseif type(opts) == 'string' then
        options = vim.tbl_extend('force', options, {
            desc = opts,
        })
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.map_func(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if type(opts) == 'table' then
        options = vim.tbl_extend('force', options, opts)
    elseif type(opts) == 'string' then
        options = vim.tbl_extend('force', options, {
            desc = opts,
        })
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

-- using nvim_feedkeys to simulate user's input
local function move_cursor_up(lines)
    vim.api.nvim_feedkeys(tostring(lines) .. 'k', 'n', false)
end

function M.has_visual_selection()
    local mode = vim.fn.mode()

    -- visul mode (v, V, Ctrl-V)
    if mode == 'v' or mode == 'V' or mode == '' then
        return true
    end

    -- if not in visual mode，check last slection still valid
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    return start_pos[2] ~= 0 and end_pos[2] ~= 0
end

-- get visual mode coordinates
-- returns: start_row, start_col, end_row, end_col (0-based)
function M.get_visual_range()
    -- return value of vim.fn.getpos
    -- pos = [
    --   1,   ← buffer no
    --   10,  ← line num
    --   5,   ← col num
    --   0    ← offset
    -- ]
    local start = vim.fn.getpos("'<")
    local end_ = vim.fn.getpos("'>")

    local start_row = start[2] - 1
    local start_col = start[3] - 1
    local end_row = end_[2] - 1
    local end_col = end_[3]

    return start_row, start_col, end_row, end_col
end

-- visual text (using '< and '>)
function M.get_visual_selection_text()
    start_row, start_col, end_row, end_col = M.get_visual_range()
    local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})

    return table.concat(lines, '\n')
end

-- replace visual text
function M.replace_visual_selection_text(new_text)
    start_row, start_col, end_row, end_col = M.get_visual_range()
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, vim.split(new_text, '\n'))
end

-- Example usage: Move the cursor up by 5 lines
-- vim.keymap.set('n', '<leader>k', function()
--   move_cursor_up(5)
-- end, { desc = "Move cursor up by 5 lines" })

-- export exports
return M
