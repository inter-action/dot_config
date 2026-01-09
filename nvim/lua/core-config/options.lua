-- General Neovim options
-- Use sensible defaults and avoid global side-effects where possible
local o = vim.opt

o.hidden = true -- allow background buffers
o.mouse = 'a' -- enable mouse
o.timeoutlen = 2000
o.autoread = true
o.signcolumn = 'yes'
o.encoding = 'utf-8'
o.scrolloff = 10
o.sidescrolloff = 10
o.showcmd = true
o.laststatus = 2
o.wrap = true
o.linebreak = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.termguicolors = true
o.title = true
o.splitbelow = true
o.completeopt = 'menu,noinsert'
o.shortmess = 'atI'
o.listchars = 'nbsp:¬,extends:»,precedes:«,trail:•'
o.whichwrap = 'b,s,<,>,[,],h,l'

-- Indentation
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

-- Search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.showmatch = true
o.gdefault = true

-- Wildmenu
o.wildmenu = true
o.wildmode = 'list:longest'

-- Folding (prefer using nvim-treesitter fold expr)
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Backspace behavior
o.backspace = 'indent,eol,start'

-- Diff options
o.diffopt = 'filler,vertical,iwhite,algorithm:patience,indent-heuristic'

-- Keep runtime global options minimal; prefer local buffer/window options where applicable

-- Expose a helper return for tests/other modules
return true