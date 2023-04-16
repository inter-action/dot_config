local exports = {}

function exports.test()
    print("worked")
end

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


-- export exports
return exports
