"----------------------------
" FONT AND COLORATION
" ---------------------------

colorscheme solarized
set background=light
" swap background with <leader>bg
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

hi Search cterm=underline ctermfg=magenta ctermbg=black
syntax on
filetype plugin indent on " Turn on plugins

if has("macunix")
    set gfn=Menlo:h11
elseif has("unix")
    set gfn=ProggyTinyTT\ 12
endif


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

nmap <leader>R :source ~/.vimrc<cr>


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
set autoindent    "carry indenting to next line
set cinkeys-=0#   "comments don't fiddle with indenting
set guioptions-=T " Get rid of the toolbar
set nu            " Line numbers, remove with :set nonumber
set hls           " Highlight searches
set is            " Search while typing
set sc            " Show partial commands
set smd           " Show mode
set sm            " Show matching parens
set path+=**      " Search down into subdirs
set wildmenu      " Display all matching files on tab
set complete-=i   " Don't search included files on autocomplete


"----------------------------
" NAVIGATION
" ---------------------------

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" When typing text, treat display lines as logical lines
au FileType html,tex,mkd noremap <buffer> j gj
au FileType html,tex,mkd noremap <buffer> k gk
" When typing text, soft break at word boundaries
au FileType html,tex,mkd set linebreak nolist 
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

" Browse by tag, using \T
Plug 'vim-scripts/taglist.vim'
nmap <Leader>T :TlistToggle<CR>

" Code folding, relies on taglist
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Startscreen that uses sessions
Plug 'mhinz/vim-startify'

" Autocomplete python, in heavy flux
" K to show docs for function
Plug 'vim-scripts/pythoncomplete', { 'for': 'python' }
Plug 'davidhalter/jedi-vim'
let g:jedi#usages_command = "<leader>N"
"Plug 'cjrh/vim-conda' " Let's us activate conda envs
"nmap <Leader>c :CondaChangeEnv<CR>
nmap <Leader>P :!python %<CR>

" Nerdtree for pseudo-project pane
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nmap <Leader>n :NERDTreeToggle<CR>

" Buffergator for Nerdtree but for buffers
Plug 'jeetsukumaran/vim-buffergator', {'on': 'BuffergatorToggle'}
nmap <Leader>bb :BuffergatorToggle<CR>
let g:buffergator_suppress_keymaps = 1

" LaTeX
Plug 'vim-latex/vim-latex', { 'for': 'latex'}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown'}

" Outliner
Plug 'vimoutliner/vimoutliner'

" Tasklist, access with \t
Plug 'vim-scripts/TaskList.vim'
let g:tlTokenList = ['FIXME', 'TODO', 'NOTE']

" For writing prose
Plug 'junegunn/goyo.vim'
  nmap <Leader>p :Goyo<CR> 

" Gitgutter
Plug 'airblade/vim-gitgutter'
  "let g:gitgutter_sign_added = '∙'
  "let g:gitgutter_sign_modified = '~'
  "let g:gitgutter_sign_removed = '∙'
  "let g:gitgutter_sign_modified_removed = '∙'
  "let g:gitgutter_realtime = 1
  "set updatetime=250 "affects a lot outside gitgutter

" Indent indicators
Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '┆'
  nmap <leader>i :IndentLinesToggle<CR>

" ALE - asynchronous linting
" toggle check with \a
" autofix with \A
Plug 'dense-analysis/ale', {'for': 'python'}
  let g:ale_linters = {'python': ['flake8']}
  let g:ale_fixers = {'python': ['autopep8', 'black', 'trim_whitespace', 'remove_trailing_lines']}
  let g:ale_python_autopep8_options = '--agressive'
  let g:ale_fix_on_save = 1
  let g:ale_sign_error = 'X'
  let g:ale_sign_warning = '~'
  let g:ale_lint_on_enter = 0
  let g:ale_enabled = 0
  nmap <leader>a :ALEToggle<CR>
  nmap <leader>A :ALEFix<CR>
  nmap <silent> \e <Plug>(ale_next_wrap)
  nmap <silent> \E <Plug>(ale_previous_wrap)

" Black python formatting
Plug 'python/black', {'for': 'python'}
  nmap <Leader>bl :Black<CR> 

" Colorscheme management
Plug 'altercation/vim-colors-solarized'

" Buffer list in statusline
Plug 'bling/vim-bufferline'
   let g:bufferline_echo = 0
   let g:bufferline_active_buffer_left = '^'
   let g:bufferline_active_buffer_right = ''
   let g:bufferline_rotate=1

" Statusline with lightline
Plug 'itchyny/lightline.vim'
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [[ 'mode', 'paste' ], 
      \            [ 'readonly', 'filename', 'modified'],
      \            ['bufferline']],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             ['filetype', 'statusclock']]
      \  },
      \ 'component_type': {
      \   'bufferline': 'tabsel',
      \  },
      \ 'component_expand': {
      \   'bufferline': 'LightlineBufferline',
      \  },
      \ 'component_function': {
      \   'statusclock': 'StatusClock',
      \  },
      \ }
  function! StatusClock()
    return strftime("%H:%M")
  endfunction
  function! LightlineBufferline()
  call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    return [b, c, a]
  endfunction
set laststatus=2

" tmux-navigator
" Navigate panes using ^-<movement-key>
" Works within vim and between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Notational velocity equivalent using :NV
" Depends on rg, fzf, fzf plugin
" Use `brew install ripgrep fzf`
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/Alok/notational-fzf-vim'
let g:nv_search_paths = ['~/Dropbox/docs/notes/notational_velocity/']
let g:nv_default_extension = '.txt'
let g:nv_use_short_pathnames = 1
au BufRead,BufNewFile *.txt set filetype=markdown

" Testing from vim
Plug 'janko/vim-test', {'for': 'python'}
  nmap <silent> <Leader>uu :TestNearest<CR> 
  nmap <silent> <Leader>uf :TestFile<CR> 
  nmap <silent> <Leader>us :TestSuite<CR> 
  nmap <silent> <Leader>ul :TestLast<CR> 
  nmap <silent> <Leader>ur :TestVisit<CR>  " return to last test
  let test#strategy = "vimterminal"


" Add plugins to &runtimepath
call plug#end()

