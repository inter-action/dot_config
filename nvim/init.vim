" debug map `:verbose map <tab>`



" TODO: migrate all other config into lua
" I don't know if this is necessary at all

lua << EOF
require('lazy-nvim')
require('core-config')
EOF

"--------------------------------------------------
" vim configurations


"-------------------------
" closetag.vim
let g:closetag_filetypes = 'html,xhtml,phtml,handlebars'


"-------------------------
" vimwiki
let g:vimwiki_list = [
  \ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
  \ {'path': '~/personalwiki/', 'syntax': 'markdown', 'ext': '.md'},
  \ ]

" limit vimwiki to the files listed in g:vimwiki_list config
" let g:vimwiki_global_ext = 0




"-------------------------
" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
nmap <Leader>m <Plug>BookmarkToggle
" nmap <Leader>i <Plug>BookmarkAnnotate
nmap <Leader>l <Plug>BookmarkShowAll
" nmap <Leader>j <Plug>BookmarkNext
" nmap <Leader>k <Plug>BookmarkPrev
" nmap <Leader>c <Plug>BookmarkClear
" nmap <Leader>x <Plug>BookmarkClearAll
" nmap <Leader>kk <Plug>BookmarkMoveUp
" nmap <Leader>jj <Plug>BookmarkMoveDown
" nmap <Leader>g <Plug>BookmarkMoveToLine


"--------------------------------------------------
" General options

set t_Co=256

" force language
" language en_US

" Enable per-directory .vimrc files and disable unsafe commands in them
"set exrc secure

" Set up leader key <leader>, i use default \
"let mapleader = ','

" Buffer will be hidden instead of closed when no one display it
set hidden

" enable mouse support for window
set mouse=a

" enlong the leader key combination typing
set timeoutlen=2000

" Auto reload changed files
set autoread

"Always draw the signcolumn.
set signcolumn=yes

" Always change current directory to current-editing-file dir
"set autochdir

" Indicates fast terminal connection
set ttyfast

" Set character encoding to use in vim
set encoding=utf-8

" Let vim know what encoding we use in our terminal
set termencoding=utf-8

" Which EOl used. For us it's unix
" Not works with modifiable=no
if &modifiable
    set fileformat=unix
endif

" increase command history size to 10000
set shada=!,'100,<50,s10,h,:10000

" Enable Tcl interface. Not sure what is exactly mean.
" hset infercase

" Interprete all files like binary and disable many features.
" set binary

"--------------------------------------------------
" Display/View options

" 启用truecolor rendering
set termguicolors

" Hide showmode
" Showmode is useless with airline
set noshowmode

" Show file name in window title
set title

" open preview window at bottom
set splitbelow

" Hide preview window for completion
" set completeopt-=preview
set completeopt=menu,noinsert

" Mute error bell
set novisualbell

" Remove all useless messages like intro screen and use abbreviation like RO
" instead readonly and + instead modified
set shortmess=atI

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Numbers of lines to scroll when the cursor get off the screen
" Useless with scrolloff
" set scrolljump=5

" Numbers of columns to scroll when the cursor get off the screen
" Useless with sidescrollof
" set sidescroll=4

" Numbers of rows to keep to the left and to the right off the screen
set scrolloff=10

" Numbers of columns to keep to the left and to the right off the screen
set sidescrolloff=10

" Vim will move to the previous/next line after reaching first/last char in
" the line with this command (you can add 'h' or 'l' here as well)
" <,> stand for arrows in command mode and [,] arrows in visual mode
set whichwrap=b,s,<,>,[,],

" Display command which you typing and other command related stuff
set showcmd

" Indicate that last window have a statusline too
set laststatus=2

" The cursor should stay where you leave it, instead of moving to the first non
" blank of the line
set nostartofline

" Disable wrapping long string
" set nowrap
set wrap linebreak nolist


" Display Line numbers
set number relativenumber

" Highlight line with cursor
set cursorline

" Maximum text length at 80 symbols, vim automatically breaks longer lines
" set textwidth=80

" Highlight column right after max textwidth
" set colorcolumn=+1


"--------------------------------------------------
" Tab options

" Copy indent from previous line
set autoindent

" Enable smart indent. It add additional indents whe necessary
set smartindent

" Replace tabs with spaces
set expandtab

" When you hit tab at start of line, indent added according to shiftwidth value
set smarttab


" Number of spaces to use for each step of indent
set shiftwidth=4

" Number of spaces that a Tab in the file counts for
set tabstop=4

" but in most cases tabstop and softtabstop better be the same
set softtabstop=4


" Round indent to multiple of 'shiftwidth'.
" Indentation always be multiple of shiftwidth
" Applies to  < and > command
" set shiftround

"--------------------------------------------------
" Search options

" Add the g flag to search/replace by default
set gdefault

" Highlight search results
set hlsearch

" Ignore case in search patterns
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase

" Live search. While typing a search command, show where the pattern
set incsearch

" Disable highlighting search result on Enter key
nnoremap <silent> <cr> :nohlsearch<cr><cr>

" Show matching brackets
set showmatch

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
nnoremap :g/ :g/\v
nnoremap :g// :g//
" cnoremap \>s/ \>smagic/


"--------------------------------------------------
" Wildmenu

set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor


"--------------------------------------------------
" Folding

set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" disable folding at startup
" set nofoldenable



"--------------------------------------------------
" Edit

" Allow backspace to remove indents, newlines and old text
set backspace=indent,eol,start

" toggle paste mode on \p
set pastetoggle=<leader>p

" Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
set iskeyword+=-

" Disable backups file
set nobackup

" Disable vim common sequence for saving.
" By default vim write buffer to a new file, then delete original file
" then rename the new file.
set nowritebackup

" Disable swp files
set noswapfile

" Do not add eol at the end of file.
set noeol

" Spellcheck
" set spell spelllang=en_us

"--------------------------------------------------
" Diff Options

" Display filler
set diffopt=filler

" Open diff in horizontal buffer
set diffopt+=vertical

" Ignore changes in whitespaces characters
set diffopt+=iwhite

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

"--------------------------------------------------
" window navigation

" split
nnoremap s- <C-w>s
nnoremap s\ <C-w>v

" close
nnoremap sc <C-w>c

" switch window
nnoremap ss <C-w>w
nnoremap sh <C-w>h
nnoremap sl <C-w>l
nnoremap sj <C-w>j
nnoremap sk <C-w>k

nnoremap <C-w><Left> <C-w>5<
nnoremap <C-w><Right> <C-w>5>
nnoremap <C-w><Up> <C-w>5+
nnoremap <C-w><Down> <C-w>5-

"--------------------------------------------------
" Navigate Options

map H ^
map L $

" switch tabs
nnoremap <M-h> gT
nnoremap <M-l> gt


"-------------------------------------------------- 
" personal options


" quick navi buffers
nnoremap <C-H> :bp<CR>
nnoremap <C-L> :bn<CR>

inoremap <C-H> <Esc>:bp<CR>
inoremap <C-L> <Esc>:bn<CR>

set pyxversion=3

" yank to system clipboard
vnoremap <silent><leader>y "+y<CR>

nnoremap j gj
nnoremap k gk

" terminal mode
" use <C-d> to close it
tnoremap <Esc> <C-\><C-n>

" hide sign column
" https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
highlight clear SignColumn

" prevent paste in visual mode from replacing unnamed buffer
xnoremap p P

" insert mode
inoremap <M-h> <Left>
inoremap <M-l> <Right>

" save current session into a file
nnoremap <F10> :wa<Bar>exe "mksession! " .. v:this_session<CR>

" folding
" nnoremap <space> za


" quickfix, combine with :set modifiable and use :cgetbuffer to recreate
" quickfix list
set errorformat+=%f\|%l\ col\ %c\|%m


"-------------------------------------------------- 
" Options config copied from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
"

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

"--------------------------------------------------
" Autocmd

augroup _general_settings
    autocmd!

    " Jump to last edit position on opening file
    " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
    autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    
    " yarnk on highlight
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()

    " see :h fo-table
    " stop auto add comment header when hit o in normal mode
    autocmd BufWinEnter * :set formatoptions-=o
    autocmd FileType qf set nobuflisted

    " no syntax highlight for 1 million lines
    " moved this check in treesitter
    " autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax off | endif

    " auto save on focus lost
    autocmd FocusLost * silent! wa
augroup end

augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
augroup end

" augroup _markdown
"     autocmd!
"     autocmd FileType markdown setlocal wrap
"     autocmd FileType markdown setlocal spell
" augroup end

augroup _filetypes
    " Set filetypes aliases
    autocmd FileType scss set ft=scss.css
    autocmd FileType less set ft=less.css
augroup end
