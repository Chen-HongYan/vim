
"Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif


"Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\|endif


"Vim-Plug
call plug#begin('~/.vim/plugged')
	Plug 'preservim/nerdtree' "NERDTree"
	Plug 'Xuyuanp/nerdtree-git-plugin' "NERDTree Plug git"
	Plug 'tpope/vim-fugitive' 
	Plug 'bling/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'majutsushi/tagbar'
	Plug 'airblade/vim-gitgutter'
	Plug 'morhetz/gruvbox'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'ludovicchabant/vim-gutentags'	

call plug#end()


"vi and vim cmpatible disable
	set nocompatible

"Syntax highlighting Enable
	syntax enable

"System theme color
	set t_Co=256
	colorscheme gruvbox
	set background=dark

	if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
		if (has("termguicolors"))
			set termguicolors
		endif
	endif
"Cursor
	set cursorline
	hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=LightYellow

"Search
	set ignorecase
	set smartcase
	set incsearch
	set hlsearch
	hi Search cterm=reverse ctermbg=none ctermfg=none

"Indent
	set cindent
	set noexpandtab
	set tabstop=8
	set softtabstop=8
	set shiftwidth=8
	set smarttab
	"set list
	set listchars=tab:>-,space:.
	hi SpecialKey guifg=darkgrey ctermfg=grey

"System Configuration
	set number
	set ruler
	set confirm
	set backspace=indent,eol,start
	set history=500
	set mouse=a
	set showcmd
	set showmode
	set autowrite
	set foldmethod=manual

"Status line
	set laststatus=2

"Buffer
	set hidden

"============================================================================
"				Vim Plug Setting 
"============================================================================

"Ctags setting
"	if has("ctags")
"		if filereadable("tags")
"			set tags=./tags,./TAGS,tags;~,TAGS;~;
"		endif
"	endif

"Cscopu setting
	if has("cscope")
		set cscopetag
		set csto=1
		set cscopeverbose
		set ttimeoutlen=250

		if filereadable("cscope.out")
			cs add cscope.out
			"else search cscope.out elsewhere
		else
			let cscope_file=findfile("cscope.out", ".;")
			"echo cscope_file
			if !empty(cscope_file) && filereadable(cscope_file)
				exe "cs add" cscope_file
			endif      
		endif

		nnoremap cs :cs find s <C-R>=expand("<cword>")<CR><CR>
		nnoremap cg :cs find g <C-R>=expand("<cword>")<CR><CR>
		nnoremap cc :cs find c <C-R>=expand("<cword>")<CR><CR>
		nnoremap ct :cs find t <C-R>=expand("<cword>")<CR><CR>
		nnoremap ce :cs find e <C-R>=expand("<cword>")<CR><CR>
		nnoremap cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
		nnoremap ci :cs find i <C-R>=expand("<cfile>")<CR><CR>
		nnoremap cd :cs finf d <C-R>=expand("<cword>")<CR><CR>
	endif

"Cocnvim
	"use <tab> to trigger completion and navigate to the next complete item
	function! CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	inoremap <silent><expr> <Tab>
	      \ coc#pum#visible() ? coc#pum#next(1) :
	      \ CheckBackspace() ? "\<Tab>" :
	      \ coc#refresh()

	inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
	inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
				      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	set updatetime=300
	au CursorHold * sil call CocActionAsync('highlight')
	au CursorHoldI * sil call CocActionAsync('showSignatureHelp')


"NERDTree
	nnoremap <F5> :NERDTreeToggle <CR>

"TagsBar
	nnoremap <F8> :TagbarToggle<CR>
	
"Resize Windows 	
	nnoremap <S-Up> <C-w>+
	nnoremap <S-Down> <C-w>-
	nnoremap <S-Left> <C-w><
	nnoremap <S-Right> <C-w>>

"Switch Windows
	nnoremap <Tab> <C-w>w
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-h> <C-w>h
	nnoremap <C-l> <C-w>l

"Switch Buffer
	nnoremap <S-h> :bprevious<CR>
	nnoremap <S-l> :bnext<CR>
	
"Switch TabPage
	nnoremap <S-Home> :tabprevious<CR>
	nnoremap <S-End> :tabnext<CR>
"voice
	set vb t_vb=
	
"gutentags Setting
	let g:gutentags_project_root = ['.tags']
 
	let g:gutentags_ctags_tagfile = '.tags'
 
	let g:gutentags_modules = []
	if executable('ctags')
	    let g:gutentags_modules += ['ctags']
	endif
	let s:vim_tags = expand('~/.cache/tags')
	let g:gutentags_cache_dir = s:vim_tags
	if !isdirectory(s:vim_tags)
	   silent! call mkdir(s:vim_tags, 'p')
	endif
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
	 
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
	let g:gutentags_auto_add_gtags_cscope = 0

"AirLine
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	
	"Unicode symbols
	let g:airline_left_sep = '»'
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '«'
	let g:airline_right_sep = '◀'
	let g:airline_symbols.colnr = ' ㏇:'
	let g:airline_symbols.colnr = ' ℅:'
	let g:airline_symbols.crypt = '🔒'
	let g:airline_symbols.linenr = '☰'
	let g:airline_symbols.linenr = ' ␊:'
	let g:airline_symbols.linenr = ' ␤:'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.maxlinenr = ''
	let g:airline_symbols.maxlinenr = '㏑'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.spell = 'Ꞩ'
	let g:airline_symbols.notexists = 'Ɇ'
	let g:airline_symbols.notexists = '∄'
	let g:airline_symbols.whitespace = 'Ξ'
	
	"Powerline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.colnr = ' ℅:'
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ' :'
	let g:airline_symbols.maxlinenr = '☰ '
	let g:airline_symbols.dirty='⚡'