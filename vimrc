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
Plug 'wgibbs/vim-irblack'

" Ruby and Rails support
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" easily change what a text is surrounded with
Plug 'tpope/vim-surround'

" syntax highlighting
Plug 'kchmck/vim-coffee-script'

call plug#end()

" ----------------------------------------------------------------------------
"   Settings
" ----------------------------------------------------------------------------
" turns on syntax highlighting
syntax on

" sets the color scheme
set background=light
:colorscheme ir_black

" fix highlighting in Ag display
hi QuickFixLine guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline

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

" make it easy to deal with different indentation styles
:nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" ctrlp file finder plugin
set wildmenu
set wildmode=list:full,list:longest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/vendor/gems/*,*/node_modules/*,*/tmp/*,*/.tmp/*
" use fd which is faster
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
" make it possible to open the same file twice
let g:ctrlp_switch_buffer = 'et'
" search in current working directory ('angelco') instead of current project
" only
let g:ctrlp_working_path_mode = 'a'
" use better C-based matcher
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" always show status line
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin on
filetype plugin indent on

" Makefile-specific settings
" This doesn't work well.
"autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

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

" Tab configuration
map <leader>bt :tabnew<cr>
map <leader>be :tabedit
map <leader>bc :tabclose<cr>
map <leader>bm :tabmove
map <leader>bn :tabn<cr>
map <leader>bp :tabp<cr>

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

" configure ControlP
let g:ctrlp_map = '<leader>t'
let g:CommandTAcceptSelectionSplitMap='<C-s>'
let g:CommandTAcceptSelectionVSplitMap='<C-CR>'
set wildignore+=*/public/paperclip/*
set wildignore+=*/tmp/*

" add diffing unsaved changes
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

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

" this will recompile my JS files and trigger a browser reload for me
command Recompile call system('touch ~/code/bonobos/spree-frontend/src/application.coffee; touch ~/code/bonobos/ayr-frontend/src/application.coffee')

" set up Ctags
set tags=./tags,tags;

" set fonts
:set guifont=Monaco:h14

" automatically strip trailing whitespace
autocmd BufWritePre Gemfile,*.js,*.coffee,*.rb,*.rake,*.styl,*.json,*.erb,*.haml,*.sass,*.scss :%s/\s\+$//e
" automatically strip trailing empty lines
autocmd BufWritePre Gemfile,*.js,*.coffee,*.rb,*.rake,*.styl,*.json,*.erb,*.haml,*.sass,*.scss :%s/\($\n\s*\)\+\%$//e

" highlight text that goes over eighty characters
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter * match OverLength /\%>80v.\+/
augroup END

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction
 
function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
 
  if filereadable(tagfilename)
    let cmd = 'ctags -a -f ' . tagfilename . ' "' . f . '"'
    call DelTagOfFile(f)
    let resp = system(cmd)
  endif
endfunction
 
autocmd BufWritePost * call UpdateTags()

command Al cd ~/code/angelco
cd ~/code/angelco
