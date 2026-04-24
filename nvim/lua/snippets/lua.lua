local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local date = function()
    return { os.date('%Y-%m-%d') }
end

ls.add_snippets('lua', {
    s('todos', {
        t('-- TODO('),
        i(1, 'p1'), -- placeholder 1
        t('): '),
        i(2, 'p2'), -- placeholder 2
        t(' ['),
        f(date, {}), -- insert date, call lua function date
        t(']'),
    }),
})

return {
    s('todo', {
        t('-- TODO: '),
    }),
}
