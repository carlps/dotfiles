let mapleader = ","
let maplocalleader = ","

set encoding=utf-8

" Plugins ---- {{{
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
Plug 'junegunn/fzf'
" Auto format (for sql)
Plug 'Chiel92/vim-autoformat'
" Codi -- interactive scratchpad
" Plug 'metakirby5/codi.vim'
" Startify -- startup screen
Plug 'mhinz/vim-startify'
" Line highlither -- color is bad
" Plug 'miyakogi/conoline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'kshenoy/vim-signature'

call plug#end()
" }}}

" stuff from vimscript book ---- {{{
nnoremap - ddp
nnoremap _ ddkP
inoremap <c-u> <esc>bveUea
nnoremap <c-u> bveUe
iabbrev pbd pdb
iabbrev ipdb import pdb; pdb.set_trace()
iabbrev frimc from ebill.invoice.models import Client
" wrap a word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
vnoremap <leader>" <esc><esc>`<i"<esc>`>la"<esc>
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>' <esc><esc>`<i'<esc>`>la'<esc>
" wrap a word in brackets
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
vnoremap <leader>[ <esc><esc>`<i[<esc>`>la]<esc>
vnoremap <leader>{ <esc><esc>`<i{<esc>`>la}<esc>
vnoremap <leader>( <esc><esc>`<i(<esc>`>la)<esc>
vnoremap <leader>< <esc><esc>`<i<<esc>`>la><esc>
" delete bracket pair (requires being on one of the brackets)
nnoremap <leader>dp %x``x

augroup leadercomments
  autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup mdcommands
  autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^\\(==\\+\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
  autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^\\(==\\+\\\|--\\+\\)$\r:nohlsearch\rg_ck0"<cr>
augroup END
" }}}

" Vimscript file settings ------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" General settings ---- {{{
" autoread for when a file is changed outside vim
set autoread
let &autoread=1
" lines to keep above and below cursor while scrolling
set scrolloff=8
" wildmenu for better tab completion
set wildmenu
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
set linebreak
set autoindent
set smartindent
set wrap

" make new splits open right and below
set splitright
set splitbelow

" Normal mode arrows resize splits
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" in visual mode, pressing * or # will search for current selection
" * goes down, # goes up.
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" tab settings
set switchbuf=useopen,usetab,newtab
set showtabline=2 
" autocmd BufAdd,BufNewFile * nested tab sball

augroup returnposition
  " Return to last edit position when opening files
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" Always show the status line
set laststatus=2
" }}}

" Format the status line ---- {{{
set statusline=\%r%.60F
set statusline+=\ %{fugitive#statusline()}
set statusline+=%=Col:%c\ Line:%l/%L
" }}}

" Python specific ---- {{{
" ignore .pyc files when autocompleting
set wildignore=*.pyc
" syntax highlighting
let python_highlight_all=1
syntax on

augroup pep
  autocmd BufNewFile,BufRead *.py:
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 |
	\ set expandtab smarttab autoindent fileformat=unix |
  	\ set colorcolumn=80
  autocmd FileType python highlight ColorColumn ctermbg=darkgray | setlocal colorcolumn=80
augroup END
" }}}

" leader stuff ---- {{{
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
augroup tabpage
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END
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
nnoremap <leader>hp :split ~/buffer.py<cr>
nnoremap <leader>qs :tabe ~/buffer.sql<cr>
nnoremap <leader>vs :vsplit ~/buffer.sql<cr>
nnoremap <leader>hs :split ~/buffer.sql<cr>
" }}}

" functions to copy/paste to X clipboard ---- {{{
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

noremap <leader>y y:call ClipboardYank()<cr>
noremap <leader>p :call ClipboardPaste()<cr>p
nnoremap <leader>Y ggVGy:call ClipboardYank()<cr>
" }}}

" Use rg with fzf in Find
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" use F3 to autoformat
noremap <F3> :Autoformat<CR>
