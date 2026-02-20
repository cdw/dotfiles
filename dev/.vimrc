"----------------------------
" DIRECTORY MANAGEMENT
" ---------------------------

" move temporary files to somewhere dropbox won't see them
set directory=~/.vimbackup
set backupdir=~/.vimbackup


"----------------------------
" LOCAL AND RECONFIGURATION
" ---------------------------

" load specifics to this host
if filereadable(expand("~/.vimlocal"))
  source ~/.vimlocal
endif

noremap <leader>R :source ~/.vimrc<cr>


"----------------------------
" SPELLING
" ---------------------------

set spell
set spellfile=~/.vim/dict.en.add
hi SpellBad ctermfg=202 ctermbg=233
" Correct spelling in insert mode
inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u


"----------------------------
" OPTIONS
" ---------------------------

" Tried and true
set expandtab     "use 4 spaces instead of a tab
set shiftwidth=4  "ditto
set softtabstop=4 "ditto
set tabstop=4     "ditto
set smarttab      "ditto
set cinkeys-=0#   "comments don't fiddle with indenting
set guioptions-=T " Get rid of the toolbar
set nu            " Line numbers, remove with :set nonumber
set hls           " Highlight searches
set is            " Search while typing
set sc            " Show partial commands
set sm            " Show matching parens
set path+=**      " Search down into subdirs
set wildmenu      " Display all matching files on tab
set belloff=all   " No flashing or sound


"----------------------------
" NAVIGATION
" ---------------------------

" Esc alternative
inoremap jj <ESC>

" Move between open buffers.
noremap <C-n> :bnext<CR>
noremap <C-p> :bprev<CR>

" When typing text, treat display lines as logical lines
autocmd FileType html,tex,markdown noremap <buffer> j gj
autocmd FileType html,tex,markdown noremap <buffer> k gk
" When typing text, soft break at word boundaries
autocmd FileType html,tex,mkd set linebreak nolist
" Use the mouse in the terminal (a=in all modes)
set mouse=a
" Allow backspace to join lines, remove indents, go past start of insert
set backspace=eol,indent,start
" What do we want to wrap? Everything
set whichwrap=b,s,h,l,<,>,~,[,]
"             | | | | | | | | |
"             | | | | | | | | +-- "]" Insert and Replace
"             | | | | | | | +-- "[" Insert and Replace
"             | | | | | | +-- "~" Normal
"             | | | | | +-- <Right> Normal and Visual
"             | | | | +-- <Left> Normal and Visual
"             | | | +-- "l" Normal and Visual (not recommended)
"             | | +-- "h" Normal and Visual (not recommended)
"             | +-- <Space> Normal and Visual
"             +-- <BS> Normal and Visual


"----------------------------
" PLUGINS
" ---------------------------

" Manage plugins with vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

"----------------------------
" Generic vim mechanics

" Simple
Plug 'altercation/vim-colors-solarized'  "colorscheme
Plug 'mhinz/vim-startify' "startscreen
Plug 'joereynolds/vim-minisnip' "snippet engine, see ~/.vim/minisnipshl
Plug 'christoomey/vim-tmux-navigator' "navigate tmux/panes with ^-<movement-key>
Plug 'qpkorr/vim-renamer' ":Renamer {dir} to edit names of files in a dir

" Browse by tag, needs `brew install universal-ctags` or equiv
Plug 'preservim/tagbar'
  nnoremap <Leader>T :TagbarToggle<CR>
  let g:tagbar_width = 30
  let g:tagbar_autofocus = 1

" Show indents
Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '┆'
  autocmd Filetype json let g:indentLine_enabled = 0

" Nerdtree file pane
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  noremap <Leader>n :NERDTreeToggle<CR>

" For writing prose
Plug 'junegunn/goyo.vim'
  noremap <Leader>p :Goyo<CR>

" Buffer list in tabline
Plug 'mengelbrecht/lightline-bufferline'

" Statusline with lightline
Plug 'itchyny/lightline.vim'
  let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': [['close']]
    \ },
    \ 'active': {
    \   'left': [[ 'mode', 'paste' ],
    \            [ 'readonly', 'filename', 'modified']],
    \   'right': [['lineinfo'],
    \             ['percent'],
    \             ['filetype']]
    \  },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }
  set laststatus=2
  set showtabline=2


"----------------------------
" Organizational

" Outliner
Plug 'vimoutliner/vimoutliner'

" Tasklist, access with \t
Plug 'vim-scripts/TaskList.vim'
  let g:tlTokenList = ['FIXME', 'TODO', 'NOTE']

" Checkboxes
Plug 'jkramer/vim-checkbox'

"----------------------------
" GIT

" Fugitive
Plug 'tpope/vim-fugitive'

" Gitgutter
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_realtime = 1
  let g:gitgutter_sign_added = '∙'
  let g:gitgutter_sign_modified = '~'
  let g:gitgutter_sign_removed = '∙'
  let g:gitgutter_sign_modified_removed = '∙'


"----------------------------
" Python

if has('nvim')
    Plug 'github/copilot.vim'
endif
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " relies on taglist
nnoremap <Leader>P :!python %<CR>

" Testing from vim
Plug 'janko/vim-test', {'for': 'python'}
  nnoremap <silent> <Leader>uf :TestFile<CR>
  nnoremap <silent> <Leader>us :TestSuite<CR>
  nnoremap <silent> <Leader>ur :TestVisit<CR> " return to last test
  if has('nvim')
    let test#strategy = "neovim"
  else
    let test#strategy = "vimterminal"
  endif

" ALE - asynchronous linting
" toggle check with \a
" autofix with \A
Plug 'dense-analysis/ale', {'for': ['python', 'markdown']}
  let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'markdown': ['markdownlint']
    \ }
  let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['autopep8', 'black'],
    \ }
  let g:ale_fix_on_save = 1
  let g:ale_enabled = 0
  nnoremap <leader>a :ALEToggle<CR>
  nnoremap <leader>A :ALEFix<CR>
  nnoremap <silent> \e <Plug>(ale_next_wrap)
  nnoremap <silent> \E <Plug>(ale_previous_wrap)


"----------------------------
" Other file types

" LaTeX
Plug 'vim-latex/vim-latex', { 'for': 'latex'}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown'}
  let g:vim_markdown_folding_style_pythonic = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_conceal_code_blocks = 0
  autocmd FileType markdown setlocal linebreak
if has("macunix")
    nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>
endif

" OpenSCAD
Plug 'torrancew/vim-openscad', {'for': 'scad'}

" HTML
Plug 'othree/html5.vim', {'for': 'html'}

" Add plugins to &runtimepath
call plug#end()


"----------------------------
" FONT AND COLORATION
" ---------------------------

syntax enable
set background=light
" swap background with <leader>bg
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

colorscheme solarized
hi Search cterm=underline ctermfg=magenta ctermbg=black
filetype plugin indent on " Turn on plugins

if has("macunix")
    set gfn=Menlo:h11
elseif has("unix")
    set gfn=ProggyTinyTT\ 12
endif
