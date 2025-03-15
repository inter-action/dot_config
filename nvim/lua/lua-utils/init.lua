local exports = {}


-- Function to retrieve and display the current cursor position
function exports.move_cursor_next()

  -- Get the current cursor position in the current window
  local current_win_id = 0
  local cursor_pos = vim.api.nvim_win_get_cursor(current_win_id)
  local line = cursor_pos[1] -- 1-based line number
  local col = cursor_pos[2] -- 0-based column number

  -- Display the cursor position in the command line
  -- print("Cursor Position: Line " .. line .. ", Column " .. col)
  vim.api.nvim_win_set_cursor(current_win_id, {line, col + 1})
end


function exports.get_buffer_relative_filename()
    -- return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. '/', '')
    return vim.fn.expand('%')
end


function exports.merge2(a, b)
    -- return vim.tbl_extend("force", unpack(arg))
    --                                       ^ arg is not working inside neovim
    return vim.tbl_extend("force", a, b)
end


-- Functional wrapper for mapping custom keybindings
function exports.map_command(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function exports.map_func(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- export exports
return exports