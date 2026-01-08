-- General options
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.timeoutlen = 2000
vim.o.autoread = true
vim.o.signcolumn = 'yes'
vim.o.encoding = 'utf-8'
--  Numbers of rows to keep to the left and to the right off the screen
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
-- Display command which you typing and other command related stuff
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.wrap = true
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.title = true
vim.o.splitbelow = true
vim.o.completeopt = 'menu,noinsert'
vim.o.shortmess = 'atI'
-- Show those damn hidden characters
vim.o.listchars = 'nbsp:¬,extends:»,precedes:«,trail:•'
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.gdefault = true
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest'
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.backspace = 'indent,eol,start'
-- vim.o.iskeyword = vim.o.iskeyword .. '-'
-- vim.o.iskeyword:append("-")
vim.o.diffopt = 'filler,vertical,iwhite,algorithm:patience,indent-heuristic'