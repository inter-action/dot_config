" debug map `:verbose imap <tab>`



" TODO: migrate all other config into lua
" I don't know if this is necessary at all
lua << EOF
require('settings')
require('mappings')
require('packer-config')
require('colorscheme-config/nightfox')
require('nvim-tree-config')
require('lsp-config/language-server')
require('lsp-config/nvim-cmp')
require('lsp-config/lsp-saga')
require('lsp-config/mason')
require('lualine-config')
require('treesitter-config')
require('telescope-config')
require('git-config/gitsigns')
require('zenmode-config')
EOF




"--------------------------------------------------
" vim configurations


"-------------------------
" closetag.vim
let g:closetag_filetypes = 'html,xhtml,phtml,handlebars'


"-------------------------
" vim-highlightedyank
let g:highlightedyank_highlight_duration = 250


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
set smartindent

" Enable smart indent. It add additional indents whe necessary
" set smartindent

" Replace tabs with spaces
set expandtab

" When you hit tab at start of line, indent added according to shiftwidth value
" set smarttab


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
" nnoremap ? ?\v
" nnoremap / /\v
cnoremap %s/ %sm/

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

" Keymap to toggle folds with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf



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
" Navigate Options

map H ^
map L $

" Moving between splits
nnoremap <C-Left> gT
nnoremap <C-Right> gt

"-------------------------------------------------- 
" personal options


set pyxversion=3

" quit & write
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader><leader>q :qa!<CR>
nnoremap <silent><leader>w :w<CR>

" yank to system clipboard
vnoremap <silent><leader>y "+y<CR>

nnoremap j gj
nnoremap k gk

" new vertical
nnoremap <silent> <space>nv :vertical new<CR>

" working with buffers
map gn :bn<cr>
map gp :bp<cr>
map gx :bd<cr>

" terminal mode
tnoremap <Esc> <C-\><C-n>

" hide sign column
" https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
highlight clear SignColumn



"-------------------------------------------------- 
" diff git, copied from https://brookhong.github.io/2016/09/03/view-diff-file-side-by-side-in-vim.html
"
function! Vimdiff()
    let lines = getline(0, '$')
    let la = []
    let lb = []
    for line in lines
        if line[0] == '-'
            call add(la, line[1:])
        elseif line[0] == '+'
            call add(lb, line[1:])
        else
            call add(la, line)
            call add(lb, line)
        endif
    endfor
    tabnew
    set bt=nofile
    vertical new
    set bt=nofile
    call append(0, la)
    diffthis
    exe "normal \<C-W>l"
    call append(0, lb)
    diffthis
endfunction
autocmd FileType diff       nnoremap <silent> <leader>vd :call Vimdiff()<CR>
autocmd FileType git       nnoremap <silent> <leader>vd :call Vimdiff()<CR>

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
" Quickfix window
" https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
nmap <F4> :QFix<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction



"--------------------------------------------------
" Quickfix window size
" https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(5, 23)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction


"--------------------------------------------------
" Autocmd

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Set filetypes aliases
au FileType scss set ft=scss.css
au FileType less set ft=less.css

" no syntax highlight for 1 million lines
au BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif

" au BufRead,BufNewFile *.json set ft=json
" autocmd BufNewFile,BufRead *.ts set filetype=typescript


" auto save on focus lost
au FocusLost * silent! wa

