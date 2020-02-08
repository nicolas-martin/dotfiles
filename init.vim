call plug#begin('~/.local/share/nvim/plugged')
	" brew upgrade golangci/tap/golangci-lint
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	" File tree
	Plug 'scrooloose/nerdtree'
	" Commenting
	Plug 'tpope/vim-commentary'
	" Auto complete
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Fuzzy file finder
	Plug 'ctrlpvim/ctrlp.vim'
	" Statusbar
	Plug 'vim-airline/vim-airline'
	" Doc on status bar
	Plug 'Shougo/echodoc.vim'
	" snippets
	Plug 'SirVer/ultisnips'
	" surround
	Plug 'tpope/vim-surround'
	" brew install the_silver_searcher
	" Plug 'mileszs/ack.vim'
call plug#end()

let mapleader = ","

" UltiSnips triggering
	let g:UltiSnipsExpandTrigger = '<C-j>'
	" let g:UltiSnipsJumpForwardTrigger = '<C-;>'
	" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Go settings
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_operators = 1
	" ---
        let g:go_metalinter_enabled = ['deadcode', 'errcheck', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused', 'varcheck']
	" let g:go_metalinter_enabled = ['vet', 'deadcode', 'errcheck', 'gosimple', 'ineffassign', 'staticcheck', 'structcheck', 'typecheck', 'unused', 'varcheck']
	" let g:go_metalinter_autosave_enabled = ["govet","golint","errcheck"]
	let g:go_metalinter_autosave = 1
	let g:go_metalinter_command = "golangci-lint"
	" let g:go_list_type = 'quickfix'
	nnoremap <leader>w :GoMetaLinter<CR>

	" ---
	let g:go_fmt_command = "goimports"
	let g:go_auto_type_info = 1
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'
	let g:go_def_mapping_enabled = 0  " disable vim-go :GoDef short cut (gd) this is handled by LanguageClient [LC]
" Default settings
	set cmdheight=2
	set noexpandtab		" tabs are tabs vs expandtab tabs are space
	set showcmd		" show command in bottom bar
	" set wildmenu	  	" visual autocomplete for command menu
	set lazyredraw		" redraw only when we need to.
	set showmatch		" highlight matching [{()}]
	set incsearch		" search as characters are entered
	set hlsearch		" highlight matches
	set noshowmode		" don't show modes (use airline instead)"
	set number relativenumber
	set autowrite
	set clipboard=unnamed
	set scrolloff=5		" Keep some distance from the bottom

	set nobackup 		" No backup file
	set nowritebackup
	set nocompatible

" Auto reloads the file when modifications were made
	set autoread
	filetype plugin indent on
	nnoremap <f1> o<Esc>
	syntax on
	nnoremap <leader>n :noh<CR>

	no <C-j> <C-w>j 
	no <C-k> <C-w>k 
	no <C-l> <C-w>l 
	no <C-h> <C-w>h 

" NERDTree
	" Close if NERDTree is the last window open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	map <C-n> :NERDTreeToggle<CR>
	map <leader>l :NERDTreeFind<cr>

" Remap ctrl-p to find file
	map <leader>p <C-p>
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_custom_ignore = 'vendor\|node_modules\|DS_Store\'
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

" File specific settings
	autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
	autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent
	autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab

" Ack finder
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" use ag with CtrlP
	" Bug: Looks through the vendored folder. 
	" ag is fast enough that CtrlP doesn't need to cache
	" let g:ctrlp_use_caching = 0 
	" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" coc settings
	set hidden 		" if hidden is not set, TextEdit might fail.
	set updatetime=300 	" You will have bad experience for diagnostic messages when it's default 4000.
	set shortmess+=c 	" don't give |ins-completion-menu| messages.
	set signcolumn=yes 	" always show signcolumns (?)
	"" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()
	" nmap <leader>d :YcmCompleter GoTo<CR>
	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)
	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)
	" Use U to show documentation in preview window
	" Try this is godoc is too slow
	nnoremap <silent> U :call <SID>show_documentation()<CR>
	" Search workspace symbols (try this at some point)
	"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
