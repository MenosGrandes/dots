function! SourceIfExists(file)
    if filereadable(expand(a:file))
        exe 'source' a:file
    endif
endfunction

call SourceIfExists("~/.config/nvim/.nvim_coc_config")
call SourceIfExists("~/.config/nvim/.nvim_plug")
call SourceIfExists("~/.config/nvim/.nvim_nerdtree")
call SourceIfExists("~/.config/nvim/.nvim_markdown")
"call SourceIfExists("~/.config/nvim/.nvim_py")
" colors
colorscheme dracula
color dracula
" Some basics:
nnoremap c "_c
filetype plugin on
syntax on
" Enable autocompletion:
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Vim sandwitch
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
"Whitespaces
autocmd BufWritePre * :%s/\s\+$//e
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
"white chars
autocmd OptionSet guicursor noautocmd set guicursor=
set ignorecase
let g:hardtime_default_on = 1
command! Config execute "e $MYVIMRC"
