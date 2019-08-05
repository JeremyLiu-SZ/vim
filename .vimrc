" THE CONFIGRATION OF VIM
"
" Maintainer:	Jeremy Liu <jeremy.liu@nxp.com>
" Last change:	2019 Jul 30
"
" To use it, place it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

autocmd BufWritePost $MYVIMRC source $MYVIMRC

" vundle env setup

filetype off
" set rtp+=~/.vim/bundle/Vundle.vim

" Install vim-Plug
" unix
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'vim-scripts/phd'

Plug 'majutsushi/tagbar'

" file list in GVIM
Plug 'scrooloose/nerdtree'

" Quick jump
Plug 'Lokaltog/vim-easymotion'

"Auto alignment and filter
Plug 'godlygeek/tabular'

" Automatic alignment
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'

" highligjt the file which edit by Ststem Verilog
Plug 'nachumk/systemverilog.vim'

Plug 'haya14busa/incsearch.vim'

call plug#end()

let mapleader=";"

set hlsearch
set nu

set t_Co=256
" set background=light
set background=dark
colorscheme solarized
set guifont=Bitstream\ Vera\ Sans\ Mono

syntax enable
syntax on

filetype plugin indent on

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=2

set nobackup

set tabpagemax=30

set foldmethod=indent
" set foldmethod=syntax
set nofoldenable

set showmatch

" pathogen.vim
" execute pathogen#infect()

" NERDTree --------------------------

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" easy-align setting -----------------

"  Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Tagbar setting --------------------- 

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

map <F5> :TlistToggle<CR>

source ~/.vim/plugin/projtags.vim
source ~/.vim/plugin/autotag.vim


" indent-guides setting --------------
"
let g:indent_guides_enable_on_vim_startup=1
" 
let g:indent_guides_start_level=2
" 
let g:indent_guides_guide_size=1
" 
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" easymotin setting ---------------------
let g:EasyMotion_smartcase = 1
map  <Leader>  <Plug>(easymotion-prefix)
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>t <Plug>(easymotion-t2)
map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>l <Plug>(easymotion-lineforward)

" incsearch setting --------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
