let vimhome=$HOME."/.vim/"
let backup_dir=vimhome."/backupfiles/"

set nocompatible
set writebackup	
set backup
set backupdir=backup_dir

set backspace=indent,eol,start

set history=50
set showcmd

set ruler
set incsearch

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2


" utf8 is the modern days crack
set encoding=utf8
set fileencodings=utf8

" Input maps
"imap ;) ()<esc>i
"set foldmethod=syntax

" Don't use Ex mode, use Q for formatting
map Q gq

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
   autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal g`\"" |
     \ endif
   augroup END

	" Coding standards for python files
	augroup python_coding	
		autocmd BufRead *.py set expandtab
		autocmd BufRead *.py set tabstop=4
		autocmd BufRead *.py set shiftwidth=4
		autocmd BufRead *.py set softtabstop=4
	augroup END

    augroup ruby_coding
      autocmd BufRead *.rb set expandtab
      autocmd BufRead *.rb set shiftwidth=2
      autocmd BufRead *.rb set tabstop=2
      autocmd BufRead *.rb set softtabstop=2
    augroup END

    augroup perl_coding
      autocmd FileType perl set expandtab
      autocmd FileType perl set shiftwidth=4
      autocmd FileType perl set tabstop=4
      autocmd FileType perl set softtabstop=4
    augroup END



    augroup ruby_coding
      autocmd BufRead *.js set expandtab
      autocmd BufRead *.js set shiftwidth=4
      autocmd BufRead *.js set tabstop=4
      autocmd BufRead *.js set softtabstop=4
    augroup END



    au! BufRead,BufNewFile *.json setfiletype json 
else
  set autoindent		" always set autoindenting on
endif

map äb :FuzzyFinderBuffer<CR>
map äf :FuzzyFinderFile<CR>
map äd :FuzzyFinderDir<CR>
map äm :FuzzyFinderMruFile<CR>
map äM :FuzzyFinderMruCmd<CR>
map äB :FuzzyFinderBookmark<CR>
map ät :FuzzyFinderTag<CR>
map äT :FuzzyFinderTaggedFile<CR>

" Input autocompletion
set completefunc=false
"set omnifunc=rubycomplete#Complete
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_rails = 1
"let g:rubycomplete_classes_in_global = 1

map ö <C-W>
map Ö :tabnext<CR>

" More portable, for if you want Caps Lock as control instead of escape.
map! <C-Space> <Esc>
map  <C-Space> <Esc>

"set showmatch
"set cpoptions-=m


" GVIM
if has("gui_running")
  "colors blugrine
  set guioptions=agimt
  set go-=m go-=T
  set vb t_vb=
  set guicursor+=a:blinkoff0,a:block
"  set guifont=Fixed\ 10
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
  colors darkspectrum
endif

:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>

" Ensure that everything is A-OKAY

" Create ~/.vim if it doesn't exist
if ! isdirectory(vimhome)
  call mkdir(vimhome, "", 0700)
endif

" Create backup directory
if ! isdirectory(backup_dir)
  call mkdir(backup_dir,  "", 0700)
endif


