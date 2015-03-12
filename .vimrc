" vundle settings
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'csapprox'                         " support all colorschemes in terminal
Plugin 'airblade/vim-gitgutter'           " show git diff in gutter
Plugin 'altercation/vim-colors-solarized' " colorscheme
Plugin 'ap/vim-css-color'                 " highlight colors in css files
Plugin 'bling/vim-airline'                " fancy status/tabline
Plugin 'autumnleaf'                       " colorscheme
Plugin 'christoomey/vim-tmux-navigator'   " tmux integration
Plugin 'cmdalias.vim'                     " create aliases for vim commands
Plugin 'dbakker/vim-projectroot'          " :ProjectRootCD finds project root
Plugin 'derekwyatt/ag.vim'                " :Ag integration
Plugin 'gilligan/textobj-gitgutter'       " ah ih git hunk object
Plugin 'glts/vim-textobj-comment'         " ac ic aC comment object
Plugin 'gmarik/Vundle.vim'                " let vundle manage vundle, required
Plugin 'godlygeek/tabular'                " :Tabular lines up text
Plugin 'kana/vim-textobj-entire'          " ae ie entire buffer object
Plugin 'kana/vim-textobj-lastpat'         " a/ i/ last pattern object
Plugin 'kana/vim-textobj-line'            " al il current line object
Plugin 'kana/vim-textobj-user'            " custom text object support
Plugin 'lokaltog/vim-easymotion'          " \\w etc. easy motion
Plugin 'majutsushi/tagbar'                " :TagbarToggle shows tags
Plugin 'maxbrunsfeld/vim-yankstack'       " M-p M-S-p yank stack
Plugin 'nelstrom/vim-qargs'               " :Qargs populates args from quickfixes
Plugin 'nelstrom/vim-visual-star-search'  " * searches for selection
Plugin 'pangloss/vim-javascript'          " Javascript syntax and indenting
Plugin 'scrooloose/syntastic'             " syntax checking
Plugin 'sjl/gundo.vim'                    " :GundoToggle shows undo tree
Plugin 'tpope/vim-commentary'             " gc comments stuff out
Plugin 'tpope/vim-dispatch'               " :Make compiles asynchronously
Plugin 'tpope/vim-fugitive'               " git wrapper
Plugin 'tpope/vim-obsession'              " save/restore sessions
Plugin 'tpope/vim-repeat'                 " dot repetition for some plugins
Plugin 'tpope/vim-surround'               " simple quoting and parenthesizing
Plugin 'unimpaired.vim'                   " complementary bracket mappings
Plugin 'wting/rust.vim'                   " rust syntax highlighting
call vundle#end()
filetype plugin indent on
" end vundle settings

" colorscheme
set t_Co=256
try
    colorscheme autumnleaf
    let g:colors_name = 'autumnleaf' " fix bug in autumnleaf colorscheme
catch
endtry

" miscellaneous settings
nnoremap <leader>ag :AgForProjectRoot<space>
nnoremap <leader>l :redraw!<enter>
runtime macros/matchit.vim                         " enable default matchit plugin
set autochdir                                      " change directory when opening files
set autoindent                                     " auto indent
set backspace=indent,eol,start                     " smart backspace
set encoding=utf-8                                 " encoding
set formatprg=par\ -w79\ -j
set guifont=Monospace\ 12,Lucida_Console:h12       " common font, slightly larger size
set guioptions-=L                                  " remove left-hand scroll bar
set guioptions-=T                                  " remove toolbar
set guioptions-=r                                  " remove right-hand scroll bar
set hidden                                         " hide unsaved buffers without prompting
set history=200                                    " history
set ignorecase                                     " required for smartcase
set incsearch                                      " search as characters are entered
set lazyredraw                                     " redraw only when we need to
set listchars=tab:▸\ ,eol:¬                        " :set list to show tabs/newlines
set noerrorbells visualbell t_vb=                  " don't beep on error
set shell=bash
set smartcase                                      " smart case-sensitivity
set splitright                                     " split right
set suffixesadd=.py,.html,.js,.css,.scss,.cpp      " for :find
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " tabs
set wildmenu                                       " visual autocomplete for command menu
set wildmode=list:longest,full                     " longest matches first
syntax enable                                      " enable syntax processing

" windows-like copy, cut, and paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V> "+gP
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
noremap <C-S-V> <C-V>
inoremap <C-S-V> <C-V>
cnoremap <C-S-V> <C-V>
if !has("unix")
    set guioptions-=a
endif

" revup shortcuts
cnoremap Find<space>a/ find authorize/
cnoremap Find<space>c/ find campaign/
cnoremap Find<space>ca/ find campaign_admin/
cnoremap Find<space> find 
cnoremap find<space>a/ find authorize/
cnoremap find<space>c/ find campaign/
cnoremap find<space>ca/ find campaign_admin/

" search priority for revup repository
set path+=$HOME/revup/work/frontend/frontend/static/**
set path+=$HOME/revup/work/**

" backup settings
set backup
set backupdir=$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp
set writebackup

" syntastic settings for c++
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++1y -Weverything -Wno-c++98-compat -Wno-padded'

" if c++ makefile doesn't exist, set a default make command
function! SetCppMakePrg()
    if !filereadable(expand("%:p:h")."/Makefile")
        setlocal makeprg=clang++\ -o\%<\ %\ -std=c++1y\ -Weverything\ -Wno-c++98-compat\ -Wno-padded\ -Werror\ -fsanitize=alignment,bool,bounds,enum,float-cast-overflow,float-divide-by-zero,function,integer,integer-divide-by-zero,null,object-size,return,shift,signed-integer-overflow,undefined,unreachable,unsigned-integer-overflow,vla-bound,vptr
    endif
endfunction

" autocommands
if has ("autocmd")
    " run grunt after editing for revup
    autocmd BufWritePost *.js,*.css,*.scss silent !$HOME/scripts/grunt.sh
    " disable automatic continuation of comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " disable flashing on error
    autocmd GUIEnter * set visualbell t_vb=
    " set default make command for c++
    autocmd BufEnter *.cpp :call SetCppMakePrg()
    " automatically mark forth scripts as executable
    autocmd BufWritePost *.fs silent !chmod +x %
    " set filetype for rust
    autocmd BufEnter *.rs set ft=rust
endif
