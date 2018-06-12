" vundle settings
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'           " show git diff in gutter
Plugin 'ap/vim-css-color'                 " highlight colors in css files
Plugin 'bling/vim-airline'                " fancy status/tabline
Plugin 'chase/vim-ansible-yaml'           " syntax highlighting for ansible yaml
Plugin 'christoomey/vim-tmux-navigator'   " tmux integration
Plugin 'cmdalias.vim'                     " create aliases for vim commands
Plugin 'csapprox'                         " support all colorschemes in terminal
Plugin 'dbakker/vim-projectroot'          " :ProjectRootCD finds project root
Plugin 'derekwyatt/ag.vim'                " :Ag integration
Plugin 'derekwyatt/vim-scala'             " scala integration
Plugin 'elmcast/elm-vim'                  " elm syntax highlighting
Plugin 'flazz/vim-colorschemes'           " colorschemes
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
Plugin 'oranget/vim-csharp'               " syntax highlighting for c#
Plugin 'pangloss/vim-javascript'          " Javascript syntax and indenting
Plugin 'scrollcolors'                     " :COLOR helps choose colorscheme
Plugin 'sjl/gundo.vim'                    " :GundoToggle shows undo tree
Plugin 'tpope/vim-commentary'             " gc comments stuff out
Plugin 'tpope/vim-dispatch'               " :Make compiles asynchronously
Plugin 'tpope/vim-fugitive'               " git wrapper
Plugin 'tpope/vim-obsession'              " save/restore sessions
Plugin 'tpope/vim-repeat'                 " dot repetition for some plugins
Plugin 'tpope/vim-surround'               " simple quoting and parenthesizing
Plugin 'unimpaired.vim'                   " complementary bracket mappings
Plugin 'w0rp/ale'                         " asynchronous lint engine
Plugin 'wting/rust.vim'                   " rust syntax highlighting
call vundle#end()
filetype plugin indent on
" end vundle settings

" colorscheme
set t_Co=256
colorscheme badwolf

" miscellaneous settings
let g:lisp_rainbow = 1                             " built-in rainbow parens for lisp
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
set mouse=a                                        " enable mouse in vim
set noerrorbells visualbell t_vb=                  " don't beep on error
if has("unix")
    set shell=bash
endif
set smartcase                                      " smart case-sensitivity
set splitright                                     " split right
set suffixesadd=.py,.html,.js,.css,.scss,.cpp      " for :find
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " tabs
set wildmenu                                       " visual autocomplete for command menu
set wildmode=list:longest,full                     " longest matches first
syntax enable                                      " enable syntax processing

" backup settings
set backup
set backupdir=$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp
set writebackup

" persistent undo
silent call system('mkdir $HOME/.vim/undo')
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" autocommands
if has ("autocmd")
    " disable automatic continuation of comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " disable flashing on error
    autocmd GUIEnter * set visualbell t_vb=
    " set filetype for cshtml
    autocmd BufEnter *.cshtml set ft=cshtml
    " set filetype for typescript
    autocmd BufEnter *.ts set ft=typescript
endif
