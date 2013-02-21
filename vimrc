" initializes the pathogen helper to manage plugions
call pathogen#infect()

" turns on syntax highlighting
syntax on

" sets auto-indet to on
filetype plugin indent on

" sets the ir_black color scheme
:colorscheme ir_black

" makes sure that Esc clears the highlights of the last search
nnoremap <SPACE> :noh<CR>

" enables search highlighting, incremental search and ignore case by default

" enables search highlighting, incremental search and ignore case by default
:set ignorecase smartcase incsearch hlsearch 

" set a shortcut to open the BestVendor directory in NERDtree
:command Bv cd ~/Programming/BestVendor/bestvendor_code
:command Bvn :NERDTree ~/Programming/BestVendor/bestvendor_code

" set a shortcut to open my .vimrc
:command Vimrc :e ~/.vimrc

" set a shortcut to go to the last open file
:nmap <C-e> :e#<CR>

" commands for storing & retrieving session
:command SessionStore :mksession! ~/.vim_session
:command SessionRestore :source ~/.vim_session

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

" tab completion
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" always show status line
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" graphical undo configuration
nmap <F5> :GundoToggle<CR>
imap <F5> <ESC>:GundoToggle<CR>

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
filetype plugin indent on

" don't make annoying sounds
set visualbell

" longer history
set history=1000

" relative line numbers but not in insert mode
autocmd InsertEnter * setl nu
autocmd InsertLeave * setl rnu

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

" change-paste mapping to replace a word with the clipboard's contents: cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" set up Ctags
set tags=./tags,tags;

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
