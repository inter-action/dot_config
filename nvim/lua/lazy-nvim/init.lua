local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- Plugin manager setup (lazy.nvim)
-- Handles plugin loading and configuration

-- If lazy.nvim is not installed, bootstrap it here
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if not ok then
    vim.notify('lazy.nvim not found; plugin management will be skipped', vim.log.levels.WARN)
    return
end

lazy.setup {
    spec = {
        { import = 'plugins' },
    },
    change_detection = { enabled = false },
    install = { colorscheme = { 'habamax' } },
    checker = { enabled = false },
}

return true
