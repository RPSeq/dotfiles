" vundle
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim,~/.fzf
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'edkolev/tmuxline.vim'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

" history
set history=10000
set undolevels=1000

" colours
syntax enable
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" editorconfig
let g:EditorConfig_core_mode = 'external_command'

" tmux statusbar
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'b': ['#(whoami)', '#(uptime | cut -d " " -f 3,4,5,6,7 | sed "s/,$//")'],
    \ 'c': '#W',
    \ 'win': ['#I', '#W'],
    \ 'cwin': ['#I', '#W'],
    \ 'x': '%a',
    \ 'y': ['%b %d', '%R'],
    \ 'z': '#H'}

let g:tmuxline_theme = {
    \   'a'    : [ 236, 103 ],
    \   'b'    : [ 253, 239 ],
    \   'c'    : [ 244, 236 ],
    \   'x'    : [ 244, 236 ],
    \   'y'    : [ 253, 239 ],
    \   'z'    : [ 236, 103 ],
    \   'win'  : [ 103, 236 ],
    \   'cwin' : [ 236, 103 ],
    \   'bg'   : [ 244, 236 ],
    \ }

" UI
set ttyfast
set mouse=a
set number
set showmode
set showcmd
set cursorline
set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak,*.pyc,*.class,~*
set lazyredraw
set showmatch
set ruler
set wrap
set guicursor+=a:blinkon0

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[5 q"
endif

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
