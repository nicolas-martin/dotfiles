let mapleader = ","
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
" Code Plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" File tree
Plug 'scrooloose/nerdtree'
" Commenting
Plug 'tpope/vim-commentary'
" Auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
" Fuzzy finder, for file or functions
Plug 'ctrlpvim/ctrlp.vim'
" Statusbar
Plug 'vim-airline/vim-airline'
" Doc on status bar
Plug 'Shougo/echodoc.vim'
" snippets
Plug 'SirVer/ultisnips'
" surround
Plug 'tpope/vim-surround'
call plug#end()

" deoplete
        let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
        " deoplete tab-complete
        inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
        " neocomplete like
        set completeopt+=noinsert
        " Remove scratch pad preview (kinda useful but annoying)
        set completeopt-=preview
        set completeopt+=noselect

" Go settings
        let g:go_highlight_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_function_calls = 1
        let g:go_highlight_operators = 1
        let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
        let g:go_metalinter_autosave = 1
        let g:go_metalinter_autosave_enabled = ['vet', 'golint']
        let g:go_fmt_command = "goimports"
        let g:go_auto_type_info = 1

" Default settings
        set cmdheight=2
        set expandtab       " tabs are spaces
        set tabstop=2       " number of visual spaces per TAB
        set softtabstop=2   " number of spaces in tab when editing
        set showcmd         " show command in bottom bar
        " set wildmenu      " visual autocomplete for command menu
        set lazyredraw      " redraw only when we need to.
        set showmatch       " highlight matching [{()}]
        set incsearch       " search as characters are entered
        set hlsearch        " highlight matches
        set noshowmode 		  " don't show modes (use airline instead)"
        set number relativenumber
        set autowrite
        set clipboard=unnamed
" move vertically by visual line
        nnoremap j gj
        nnoremap k gk


set nocompatible
filetype plugin indent on
syntax on

        map <C-n> :NERDTreeToggle<CR>
        no <C-j> <C-w>j "switching to below window 
        no <C-k> <C-w>k "switching to above window
        no <C-l> <C-w>l "switching to right window 
        no <C-h> <C-w>h "switching to left window
" Remap ctrl-p to find file
        map <leader>p <C-p>
        let g:ctrlp_working_path_mode = 'ra'
" Find struct and functions in go
        au FileType go nmap <leader>t :GoDecls<CR>
" Navigating tabs
        nnoremap <leader>1 1gt
        nnoremap <leader>2 2gt
        nnoremap <leader>3 3gt
        nnoremap <leader>4 4gt
        nnoremap <leader>5 5gt
        nnoremap <leader>6 6gt
        nnoremap <leader>7 7gt
        nnoremap <leader>8 8gt
        nnoremap <leader>9 9gt
