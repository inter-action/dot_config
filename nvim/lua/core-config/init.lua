-- Core configuration entrypoint
-- Each module should be idempotent and return quickly when required
local modules = {
    'core-config/options',
    'core-config/mappings',
    'core-config/auto-commands',
    'core-config/commands',
    'core-config/diagnostic',
}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        vim.notify(string.format('Failed to load %s: %s', mod, err), vim.log.levels.WARN)
    end
end

return true
