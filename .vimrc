let mapleader = ","

set encoding=utf-8

" plug for plugins
call plug#begin('~/.vim/plugged')

" Show line indentions
Plug 'Yggdroot/indentline'
" flake8
Plug 'nvie/vim-flake8'
" git stuff
Plug 'tpope/vim-fugitive'
" file tree
Plug 'scrooloose/nerdtree'
" fzf
Plug 'junegunn/fzf.vim'
" sql stuff
Plug 'vim-scripts/SQLUtilities'
" align (needed for SQL Formatter)
Plug 'vim-scripts/align'
" Codi -- interactive scratchpad
Plug 'metakirby5/codi.vim'
" Startify -- startup screen
Plug 'mhinz/vim-startify'
" Line highlither -- color is bad
" Plug 'miyakogi/conoline.vim'

call plug#end()

" stuff from vimscript book
nnoremap - ddp
nnoremap _ ddkP
inoremap <c-u> <esc>bveUea
nnoremap <c-u> bveUe

" autoread for when a file is changed outside vim
set autoread

" lines to keep above and below cursor while scrolling
set so=8

" wildmenu for better tab completion
set wildmenu

" ignore .pyc files when autocompleting
set wildignore=*.pyc

" Enable folding
set foldmethod=indent
set foldlevel=99
" show folds in left column
set foldcolumn=1

" Enable folding with the spacebar
nnoremap <space> za

" show line numbers and ruler
set number
set ruler

" ignore case when searching lower only
set ignorecase
set smartcase 
" Set ctrl-l to unhighlight searchterms
nnoremap <silent> <C-l> :nohl<CR><C-l>

" syntax highlighting
let python_highlight_all=1
syntax on

set linebreak
set autoindent
set smartindent
set wrap

" make new splits open right and below
set splitright
set splitbelow

" in visual mode, pressing * or # will search for current selection
" * goes down, # goes up.
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" leader stuff
nnoremap <leader>vr :vsplit $MYVIMRC<cr>
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>rn :set relativenumber!<cr>
" leader nerdtree
nnoremap <leader>kb :NERDTree<cr>
" leader tab stuff
nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>tp :tabprev<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove 
nnoremap <leader>tw :tabnew<cr>
" leader tl toggle between this and last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" Open a new tab with current buffer path
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>ve :vsplit <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>he :split <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" quickly open a buffer for scribble
nnoremap <leader>qq :tabe ~/buffer<cr>
nnoremap <leader>qp :tabe ~/buffer.py<cr>
nnoremap <leader>vp :vsplit ~/buffer.py<cr>

" quickly open a markdown buffer for scribble
nnoremap <leader>x :tabe ~/buffer.md<cr>

" format sql
nnoremap <leader>sq :SQLUFormatter<cr>

" tab settings
set switchbuf=useopen,usetab,newtab
set showtabline=2 
" au BufAdd,BufNewFile * nested tab sball

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ CWD:\ %r%{getcwd()}%h\ %{fugitive#statusline()}\ \ \ Line:\ %l\ \ Column:\ %c
" TODO add git.

" pep8
au BufNewFile,BufRead *.py:
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 |
	\ set expandtab smarttab autoindent fileformat=unix

" functions to copy/paste to X clipboard
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

noremap <leader>y y:call ClipboardYank()<cr>
noremap <leader>p :call ClipboardPaste()<cr>p
nnoremap <leader>Y ggVGy:call ClipboardYank()<cr>
