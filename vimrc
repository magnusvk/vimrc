" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" parse ANSI color codes
Plug 'vim-scripts/AnsiEsc.vim'

" copy & paste history
Plug 'vim-scripts/YankRing.vim'

" zoom into current window
Plug 'vim-scripts/ZoomWin'

" full-text search
Plug 'mileszs/ack.vim'

" quick search through file names
Plug 'ctrlpvim/ctrlp.vim'
" smarter ctrl-p matching
Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }

" easily comment / uncomment blocks
Plug 'scrooloose/nerdcommenter'

" show files in tree
Plug 'scrooloose/nerdtree'

" auto-complete in insert mode
Plug 'ervandew/supertab'

" show syntax errors
Plug 'scrooloose/syntastic'

" automatically close blocks
Plug 'tpope/vim-endwise'

" Git integration
Plug 'tpope/vim-fugitive'

" color scheme
Plug 'chriskempson/base16-vim'

" Ruby and Rails support
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundle'
Plug 'vim-ruby/vim-ruby'

" easily change what a text is surrounded with
Plug 'tpope/vim-surround'
" Make vim-surround repeatable with .
Plug 'tpope/vim-repeat'

" syntax highlighting
Plug 'kchmck/vim-coffee-script'

" fancy status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" rename and delete files from vim
Plug 'tpope/vim-eunuch'

" quickly switch between one-line and multi-line code
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

" ----------------------------------------------------------------------------
"   Settings
" ----------------------------------------------------------------------------
" turns on syntax highlighting
syntax on

" sets the color scheme
colorscheme base16-default-dark
let g:airline_theme='base16'

" enable powerline symbols in airline
let g:airline_powerline_fonts = 1

" use (faster) ag for Ack
let g:ackprg = 'ag --vimgrep --path-to-ignore ~/.ignore'

" makes sure that Esc clears the highlights of the last search
nnoremap <SPACE> :noh<CR>

" enables search highlighting, incremental search and ignore case by default
:set ignorecase smartcase incsearch hlsearch 

" set a shortcut to open my .vimrc
:command Vimrc :e ~/.vimrc

" set a shortcut to go to the last open file
:nmap <C-e> :e#<CR>

" commands for storing & retrieving session
:command SessionStore :mksession! ~/.vim/session
:command SessionRestore :source ~/.vim/session

" set encoding
set encoding=utf-8

" no need to be compatible, is there?
set nocompatible

" set leader key to ,
let mapleader = ','
let g:mapleader = ','
let localleader = ','
let g:localleader = ','
let leader = ','
let g:leader = ','

" always show position at the bottom of the window
set ruler

" show line numbers
set number

" use spaces instead of tabs
set expandtab

" a tab is two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" ctrlp file finder plugin
set wildmenu
set wildmode=list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/vendor/gems/*,*/node_modules/*,*/tmp/*,*/.tmp/*
set wildignore+=*/public/paperclip/*
set wildignore+=*/tmp/*
" use fd which is faster
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
" make it possible to open the same file twice
let g:ctrlp_switch_buffer = 'et'
" search in current working directory ('angelco') instead of current project
" only
let g:ctrlp_working_path_mode = 'a'
" use better C-based matcher
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" keyboard shortcut
let g:ctrlp_map = '<leader>t'

" always show status line
set laststatus=2

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin on
filetype plugin indent on

" Make sure git commit messages always have the cursor on the first line
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" don't make annoying sounds
set visualbell

" longer history
set history=1000

" Turn backup off, we don't want to clutter our directories
set nobackup
set nowb

" directory to place swap files in
set directory=~/.vim/tmp 

" toggle comments
map <leader>c <plug>NERDCommenterToggle<CR>

" Zoom Zoom Zoom
map <Leader><Leader> :ZoomWin<CR>

" make w unesseassary in ctrl-w-hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" when lines break, step over the broken-up lines one by one
:nmap j gj
:nmap k gk

" configure NERDtree
let g:NERDTreeChDirMode=2
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=0
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']
let NERDTreeMapOpenInTab='<C-t>'
let NERDTreeMapOpenSplit='<C-s>'
let NERDTreeMapOpenVSplit='<C-v>'
map <Leader>n :NERDTreeToggle<CR>

" always show MacVim's tab bar, even if there is only one tab
set showtabline=2

" Don't show toolbar
set guioptions-=T

" disable scrollbars
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L

" open YankRing on control-space
nnoremap <silent> <C-space> :YRShow<CR> 

" sync with system clipboard
set clipboard=unnamed

" highlight HamlC as we would Haml
au BufRead,BufNewFile *.hamlc set ft=haml

" change-paste mapping to replace a word with the clipboard's contents: cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" set fonts
:set guifont=Monaco\ for\ Powerline:h14

" automatically strip trailing whitespace
autocmd BufWritePre Gemfile,*.js,*.coffee,*.rb,*.rake,*.styl,*.json,*.erb,*.haml,*.sass,*.scss :%s/\s\+$//e
" automatically strip trailing empty lines
autocmd BufWritePre Gemfile,*.js,*.coffee,*.rb,*.rake,*.styl,*.json,*.erb,*.haml,*.sass,*.scss :%s/\($\n\s*\)\+\%$//e

" highlight text that goes over eighty characters
augroup vimrc_autocmds
  autocmd BufEnter *.rb,*.coffee,*.rake highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *.rb,*.coffee,*.rake match OverLength /\%>80v.\+/
augroup END

command Al cd ~/code/angelco
cd ~/code/angelco
