local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Plugin manager setup (lazy.nvim)
-- Handles plugin loading and configuration

-- If lazy.nvim is not installed, bootstrap it here
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  change_detection= {
    enabled = false,
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
