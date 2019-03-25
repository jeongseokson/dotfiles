" Maintainer: Jeongseok Son <jeongseok.son@gmail.com>

" plugin
if filereadable($HOME.'/.vim/plugins.vim')
    source $HOME/.vim/plugins.vim
endif

if &compatible
  set nocompatible
endif

if &history < 1000
  set history=1000
endif

if has('autocmd')
  filetype plugin indent on
endif

set autoread

let mapleader = ","
nmap <leader>w :w!<cr>

set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignorecase

set showcmd

set ruler

set laststatus=2

set scrolloff=5

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]

set ignorecase
set smartcase
set hlsearch
set incsearch

set lazyredraw

set magic
set showmatch

set noerrorbells
set novisualbell
set t_vb=
set tm=500

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set background=dark

set encoding=utf8
set ffs=unix,dos,mac

set nobackup
set noswapfile

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap

map <silent> k gk
map <silent> j gj
sunmap k
sunmap j

map <silent> <leader><leader> :noh<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" buffer
map <leader>bd :bd<cr>
map <leader>ba :bufdo bd<cr>
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>

" tab
map <leader>to :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>

set switchbuf=useopen,usetab,newtab
set stal=2

match ErrorMsg '\s\+$'
autocmd FileType c,cpp,java,python,javascript,ruby,vim,bash setlocal cc=100

set nu

" undo
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" ctags
set tags+=tags;~

" cscope
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

" nvim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

inoremap <C-U> <C-G>u<C-U>

set nrformats-=octal

map Q gq

" jump to the last cursor position
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" diff with an original file
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
