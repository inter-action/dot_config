local exports = {}

function exports.merge_tables(a, b)
    local temp = {}
    merge_table(temp, a)
    merge_table(temp, b)
    return temp
end

function exports.get_buffer_relative_filename()
    return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. '/', '')
end

-- private function
function merge_table(first_table, second_table)
    for k,v in pairs(second_table) do first_table[k] = v end
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
