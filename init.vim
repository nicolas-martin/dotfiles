call plug#begin('~/.local/share/nvim/plugged')
	" brew install golangci/tap/golangci-lint
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	" File tree
	Plug 'preservim/nerdtree'
	" Auto complete
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Fuzzy file finder
	Plug 'ctrlpvim/ctrlp.vim'
	" Statusbar
	Plug 'vim-airline/vim-airline'
	" snippets
	" Doesn't work on fresh install. Additional steps?
	Plug 'SirVer/ultisnips'
	Plug 'morhetz/gruvbox'
	" surround
	Plug 'tpope/vim-surround'
	" Commenting
	Plug 'tpope/vim-commentary'
	" brew install the_silver_searcher
	" Plug 'mileszs/ack.vim'
	" NOTE: Do I need ctags for gotags to work?
	" brew install gotags
	Plug 'preservim/tagbar'
	" Plug 'dstein64/vim-startuptime'
	" Plug 'jiangmiao/auto-pairs'
	Plug 'leafgarland/typescript-vim'
call plug#end()
let mapleader = ","

" python. Use custom pyenv with py3nvim
" :h python3_host_prog has the commands to set this up
	let g:python3_host_prog = '/Users/nmartin/.pyenv/versions/py3nvim/bin/python'
	autocmd FileType python setlocal signcolumn=yes
	call coc#config('python', {'pythonPath': $PYENV_VIRTUAL_ENV})

" rust
	autocmd FileType rust setlocal signcolumn=yes

" typescript
	autocmd FileType typescript setlocal signcolumn=yes
	autocmd FileType typescriptreact setlocal signcolumn=yes

" tagbar
	nmap <F2> :TagbarToggle<CR>
	" :TagbarGetTypeConfig go
	" Fold package, imports
	let g:tagbar_type_go = {
	    \ 'kinds' : [
		\ 'p:package:1',
		\ 'i:import:1',
		\ 'c:constants:0:0',
		\ 'v:variables:0:0',
		\ 't:types:0:0',
		\ 'n:intefaces:0:0',
		\ 'w:fields:0:0',
		\ 'e:embedded:0:0',
		\ 'm:methods:0:0',
		\ 'r:constructors:0:0',
		\ 'f:functions:0:0',
		\ '?:unknown',
	    \ ],
	\ }

" UltiSnips
" I also did some magic with the folders..
	let g:UltiSnipsExpandTrigger="<c-l>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" Theme
	" Theme
	syntax enable
	colorscheme gruvbox
	set termguicolors
	let g:airline_theme='gruvbox'

" Go settings
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1 
	let g:go_highlight_function_calls = 1
	let g:go_highlight_operators = 1
	" MetaLinter is not the default anymore
	nnoremap <leader>w :GoMetaLinter<CR>
	let g:go_metalinter_command = "staticcheck"
	let g:go_fmt_command = "goimports"
	" let g:go_auto_type_info = 1
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'
	let g:go_def_mapping_enabled = 0  	" disable vim-go :GoDef short cut (gd) this is handled by LanguageClient [LC]
	let g:go_debug_log_output='' 		" supress internal dlv debug
	let g:go_debug_windows = {
		\ 'vars':       'leftabove 30vnew',
		\ 'stack':      'leftabove 20new',
		\ 'goroutines': 'botright 10new',
		\ 'out':        'vsplit 10new',
	\ }
	" By default the keys only work on the current buffer
	augroup vim-go-debug
		autocmd! * <buffer>
		autocmd FileType go nmap <F5>   <Plug>(go-debug-continue)
		autocmd FileType go nmap <F6>   <Plug>(go-debug-print)
		autocmd FileType go nmap <F9>   <Plug>(go-debug-breakpoint)
		autocmd FileType go nmap <F10>  <Plug>(go-debug-next)
		autocmd FileType go nmap <F11>  <Plug>(go-debug-step)
	augroup END
	doautocmd vim-go-debug FileType go
	autocmd FileType go setlocal signcolumn=yes

" Default settings
	set cmdheight=2
	set noexpandtab			" tabs are tabs vs expandtab tabs are space
	set showcmd			" show command in bottom bar
	set lazyredraw			" redraw only when we need to.
	set showmatch			" highlight matching [{()}]
	set incsearch			" search as characters are entered
	set hlsearch			" highlight matches
	set noshowmode			" don't show modes (use airline instead)"
	set number relativenumber
	set autowrite
	set clipboard+=unnamedplus
	set scrolloff=5			" Keep some distance from the bottom
	set sidescrolloff=5 		" Keep some distance while side scrolling
	set nobackup 			" No backup file
	set noswapfile 			" NOTE: Experimental No swap file
	set nowritebackup
	set foldmethod=syntax 		" Code folding
	set foldlevelstart=20 		" Opens X amount of fold at the start - Can't use nofoldenable
	set splitright			" Split window appears right the current one.
	set autoread 			" Auto reloads the file when modifications were made
	" set nocompatible 		" enter the current millenium (nvim is always nocompatible?)
	" syntax on
	" filetype plugin indent on
	set ignorecase
	set encoding=utf-8
	nnoremap <f1> o<Esc>
	nnoremap <leader>n :noh<CR>
	no <C-j> <C-w>j
	no <C-k> <C-w>k
	no <C-l> <C-w>l
	no <C-h> <C-w>h

	" get rid of the evil ex mode
	nnoremap Q <nop>
	" define sensible backspace behaviour. See :help backspace for more details
	set backspace=2

" NERDTree
	" Close if NERDTree is the last window open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" " If more than one window and previous buffer was NERDTree, go back to it.
	" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
	map <C-n> :NERDTreeToggle<CR>
	map <leader>l :NERDTreeFind<cr>
	let g:NERDTreeRespectWildIgnore = 1

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
	autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab
	autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab  autoindent
	autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent
	autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" ag
if executable('ag')
	" TODO: Find out why ag search open up in the wrong buffer when tagbar is opened
	let g:ackprg = 'ag --vimgrep'
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor\ --ignore-dir=vendor
	" use ag with CtrlP
	let g:ctrlp_use_caching = 0 
	let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir=vendor --ignore .git -g ""'
endif
	" bind \ (backward slash) to grep shortcut
	command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
	nnoremap \ :Ag<SPACE>

" coc settings
	set hidden 		" if hidden is not set, TextEdit might fail.
	set updatetime=300 	" You will have bad experience for diagnostic messages when it's default 4000.
	set shortmess+=c 	" don't give |ins-completion-menu| messages.
	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <C-l>
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
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nmap <silent> <leader>rn <Plug>(coc-rename)
	nmap <silent> <leader>as V<Plug>(coc-codeaction-selected)
	nmap <silent> <leader>a <Plug>(coc-codeaction-line)
	nmap <silent> <leader>cl <Plug>(coc-codelens-action)	
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	" Use <leader>K to show documentation in preview window
	nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocActionAsync('doHover')
	  endif
	endfunction


	" Add status line support, for integration with other plugin, checkout `:h coc-status`
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" custom snippets
 	" Create comment from the function name of an instance function
	autocmd FileType go nnoremap <leader>mc f)wyawki//<Esc>pa<Space>
	function! Count( word )
	  redir => cnt
		silent exe '%s/' . a:word . '//n'
	  redir END
	  return matchstr( cnt, '\d\+' )
	endfunction

	function! FormatLog()
	  let @q='nvnk$J'
	  let @/ = 'WebsocketHandler'
	  let n = Count('WebsocketHandler')-20
	  execute "normal /\<cr>"
	  execute "normal ".n."@q"
	  execute "%s/ \\+/ /g"
	endfun
