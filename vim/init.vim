function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

call SourceIfExists("~/.config/nvim/.nvim_coc_config")
call SourceIfExists("~/.config/nvim/.nvim_plug")
call SourceIfExists("~/.config/nvim/.nvim_nerdtree")
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
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Vim sandwitch
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
set wildmenu
set laststatus=2
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch
"Whitespaces
autocmd BufWritePre * :%s/\s\+$//e
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
"white chars
set list
set listchars=tab:›\ ,eol:¬,trail:⋅
set clipboard+=unnamed
set guicursor=
" Workaround some broken plugins which set guicursor indiscriminately.
autocmd OptionSet guicursor noautocmd set guicursor=
set ignorecase
let g:hardtime_default_on = 1
command! Config execute "e $MYVIMRC"

set rtp+=/afs/seli.gic.ericsson.se/app/vbuild/RHEL6-x86_64/fzf/0.21.1/bin/fzf
