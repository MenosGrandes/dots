"Only for NEOVIM
if( has('win32'))
    let plugLocation=expand('$LOCALAPPDATA/nvim/autoload/plug.vim')
    echo 'Windows'
elseif  (has('unix'))
    let plugLocation=expand('~/.config/nvim/autoload/plug.vim')
    echo 'Unix'
endif
if ! filereadable(expand(plugLocation))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    let plugDir = trim(plugLocation,'/plug.vim')
    echo plugDir
    call mkdir(plugDir, "p")
    execute '!curl -fLo ' . plugLocation .' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim '
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
    syntax on
    call plug#begin('~/.vim/plugged')
    Plug 'dracula/vim'
    Plug 'scrooloose/nerdTree'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'machakann/vim-sandwich'
" Initialize plugin system
    call plug#end()
" colors
    colorscheme dracula
    color dracula

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Nerd tree
    map <leader>n :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" Vim sandwitch
    let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
