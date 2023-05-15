local exports = {}



function exports.get_buffer_relative_filename()
    return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. '/', '')
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
