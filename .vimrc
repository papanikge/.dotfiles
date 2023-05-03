"
" Hacked together by George 'papanikge' Papanikolaou.
" Third-ish version 2011-2021, optimized for Linux
" Changing from crappy pathogen (to avoid submodules) to vim-plug. 07/2017
"

" First, move to no-old-vi-compatible mode
set nocompatible

let os = substitute(system('uname'), "\n", "", "")

" }-------------------------------- Plugins ---------------------------------{
"
call plug#begin('~/.vim/plugged')

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth/'
Plug 'vim-ruby/vim-ruby',           { 'for': 'ruby' }
Plug 'tpope/vim-rails',             { 'for': 'ruby' }
Plug 'tpope/vim-bundler',           { 'for': 'ruby' }
Plug 'tpope/vim-endwise',           { 'for': 'ruby' }
Plug 'fatih/vim-go',                { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim',          { 'for': 'rust' }
Plug 'guns/vim-clojure-static',     { 'for': 'clojure' }
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree',         { 'on': 'UndotreeToggle' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'ludovicchabant/vim-gutentags'
Plug 'terryma/vim-smooth-scroll'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'pseewald/vim-anyfold',    { 'on': 'AnyFoldActivate' }
Plug 'arecarn/vim-fold-cycle'
Plug 'frazrepo/vim-rainbow'

" Experiment:
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }

Plug 'junegunn/fzf.vim'
if os == "Linux"
  Plug '~/.fzf'
else
  Plug '/usr/local/opt/fzf'
endif

" force autoread on terminal vim.
if os == "Linux"
  Plug 'amerlyq/vim-focus-autocmd'
else
  Plug 'sjl/vitality.vim'
endif

" colors
Plug 'ayu-theme/ayu-vim'

call plug#end()

" }----------------------------- Basic options ------------------------------{

" Turn on syntax highlighting, and filetype plugin detection
syntax enable
filetype plugin indent on

" Changing the leaders for easy access
let mapleader = ","
let maplocalleader = "|"

" Always display mode & keys that I press as I press them
set showmode
set showcmd

" Intuitive backspacing
set backspace=indent,eol,start

" Handle multiple buffers better
set hidden

" Case-insensitive searching
set ignorecase
" But case-sensitive if expression contains a capital letter
set smartcase

set number
" smart line joining
set formatoptions+=j
" Show cursor position
set ruler

" Highlight matches as you type
set incsearch
set hlsearch

" Don't continue at top when searching
set nowrapscan

" Don't wrap
set nowrap

" Don't redraw while executing macros
set lazyredraw

" Fast terminal
set ttyfast

" Set to auto read when a file is changed from the outside
set autoread

" Be a little smart about indenting, vim
set autoindent

" No beeping.
set visualbell

" Don't make a backup before overwriting a file
set nobackup
set nowritebackup
set noswapfile " I'm not sure about this

" History and undo levels
set undolevels=400
set history=100

" Hidden characters
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set list

" Line margin when moving vertically
set scrolloff=2

" Show the status line all the time
set laststatus=2

" Tabs. With spaces. vim-sleuth takes care of more intricate settings
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Make Esc work faster
set ttimeoutlen=50

" Spelling languages
set spelllang=en,el

" Enhanced command line completion, like a shell
set wildmenu
set wildmode=list:longest
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.pdf    " binary images and pdfs
set wildignore+=*.mp3,*.mp4,*.mkv,*.m4a,*.m3u    " music data files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.swp?                           " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python bytecode

if os == "Linux"
  " truecolor support
  set t_Co=256
  set termguicolors
end

set mouse=a

" make vim use systemclipboard
if os == "Linux"
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" }------------------------------- Appearance -------------------------------{

" Colorize the column
set colorcolumn=80

" colors
colorscheme jellybeans

if has("gui_running")
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=b
  set guioptions-=m
endif

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }------------------------------- Remappings -------------------------------{

" Multiple indentations in visual mode and single stroke in normal mode
" removed << remappings in normal mode because they were useless because of
" the different < mappings. (e.g. <, to shift function arguments)
vnoremap < <gv
vnoremap > >gv

" Make pasting smarter in visual mode
vnoremap p "_dP

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Better w-e-b keys
nnoremap w W
nnoremap e E
nnoremap b B

" Fix the Y key
nnoremap Y y$

" Just use Q to quit
noremap Q :bd<CR>

" Tabs
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

noremap <silent> <c-b> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll, 5, 2)<CR>

" remap basic keys (because I want to use J,K in a diff way)
" carefull: these should of course be in order
" nnoremap T H
nnoremap H J
" nnoremap J 15j
" " overwrite vim-fireplace's K (doc) first
" autocmd Syntax clojure nnoremap M K
" nnoremap K 15k

" System clipboard
if os == "Linux"
  vnoremap gy "+y
  nnoremap gp o<ESC>"+p
  nnoremap gP O<ESC>"+p
else
  vnoremap gy "*y
  nnoremap gp o<ESC>"*p
  nnoremap gP O<ESC>"*p
endif

" Backspace to visual delete in oblivion
vnoremap <BS> "_d

" Stay in place when hitting *
nnoremap * *N

" format the sentence or the visual selection
nnoremap \ gq)
vnoremap \ gq

" Why the hell would you have ^,$ for first, last characters?
" The remapping of '-' breaks expand-region shrink action, but meh
noremap - $
noremap 0 ^
noremap ^ 0

" Make the [{ keys useful
" go to begging/end of current block
nnoremap [[ [{
nnoremap ]] ]}

" jump to definition - if you can
" nnoremap gd <C-]>
nmap <silent> gs <Plug>(coc-definition)
" uuuuuuh
nmap <silent> gd :ALEGoToDefinition<CR>

autocmd Syntax go nnoremap gd :GoDef<CR>
autocmd Syntax go nnoremap gt :GoDecls<CR>

" Use ? for substitution. I never use it to search backwards anyway
nnoremap ? :%s/<C-R><C-W>//g<left><left>

" }---------------------------- Leader shortcuts ----------------------------{

" Select all
nnoremap <leader>a ggVG

" Select (last?) pasted text
nnoremap <leader>p `[v`]

" No Highlighted search
nnoremap <leader><Space> :nohlsearch<CR>

" Open the NERDTRee plugin
nnoremap <leader>t :NERDTree<CR>

" changing from Gundo to undotree due to ext deps
nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gb :GitGutterBufferToggle<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>
nnoremap <Leader>ga :GitGutterStageHunk<CR>
nnoremap <Leader>gr :GitGutterUndoHunk<CR>
nnoremap <Leader>gv :GitGutterPreviewHunk<CR>
nnoremap <Leader>gf :GitGutterFold<CR>

" Show invisible characters
nnoremap <leader>c :set list!<CR>:IndentLinesToggle<CR>

" Remove trailing whitespace
nnoremap <leader>z :%s/\s\+$//e<CR>:nohlsearch<CR>

" Easily open a new vertical window
nnoremap <leader>v :vnew<CR><C-W>L

" Switch cwd to the directory of the current buffer (mnemonic: here)
nnoremap <leader>h :cd %:p:h<CR>:pwd<CR>

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <leader>w mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Diff options
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff!<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

" Easy edit. Useless because of fzf but I'm used to them
nnoremap <leader>eb :e ~/.bashrc<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>ea :e ~/.aliases<CR>
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>eg :e ~/.gitconfig<CR>
nnoremap <leader>ei :e ~/.i3/config<CR>

" Fold
nnoremap <leader>o :AnyFoldActivate<CR>

" ale linter toggle
nnoremap <leader>l :ALEToggle<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <m-b> <S-left>
cnoremap <m-f> <S-right>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null<CR>

" Debugger for ruby (plugin idea: this for every language)
nnoremap <leader>b obinding.pry<ESC>

" Filter file thru jq
nnoremap <leader>j :%!jq '.'<CR>

" Copy filename into clipboard
if os == "Linux"
  nnoremap <leader>n :let @*=expand("%")<CR>
else
  nnoremap <leader>n :let @+=expand("%")<CR>
endif

" }---------------------------- Auto and plugins ----------------------------{

autocmd BufRead,BufNewFile *mutt-* setlocal ft=mail cc=72 " Mail
autocmd FocusGained,BufEnter * :checktime " force autoread on terminal vim
autocmd Syntax mail,mkd setlocal spell " Enable spelling to specific text filetypes
autocmd Syntax markdown,mkd setlocal conceallevel=0
autocmd Syntax go setlocal list!

" Abbreviations for correction and ease
iabbrev teh the
iabbrev adn and
iabbrev hten then
cabbrev h vert bo help

" Powerline with the light-weight airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#displayed_head_limit = 13
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" NERD_Tree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeHighlightCursorline = 1

" Case insensitive sneak
let g:sneak#use_ic_scs = 1

" leave my ctrl-t alone vim-go
let g:go_def_mapping_enabled = 0

" Rust
let g:rustfmt_autosave = 1

" Ruby
let ruby_no_expensive = 1

" gutentags
let g:gutentags_ctags_exclude=["node_modules", "plugged", "tmp", "temp", "log",
      \"vendor", "test", "spec", "app/assets", "*.go", "*.css", "*.html",
      \"*.json", ".yaml", "test"]
let g:gutentags_exclude_filetypes=['go']
let g:gutentags_cache_dir = '~/.cache/gutentags'

" FZF is the new champ
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_command_prefix = 'F'
nnoremap <c-p> :FFiles<CR>
nnoremap <c-t> :FTags<CR>
nnoremap gt    :FBTags<CR>
nnoremap <c-y> :FGFiles?<CR>
nnoremap <c-u> :FHistory<CR>
nnoremap <leader>k :FBCommits!<CR>
nnoremap <leader>m :FMarks<CR>
nnoremap <leader>f :FRg<CR>
nnoremap # :FRg <C-R><C-W><CR>
" this requires a newer vim - curse you debian
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Fold cycle
let g:fold_cycle_default_mapping = 0 "disable default mappings
nnoremap <CR> [j
nmap <Space> <Plug>(fold-cycle-open)
nmap <BS> <Plug>(fold-cycle-close)

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'javascript': ['eslint', 'prettier'],
  \ }
" Fixers for command :ALEFix
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" enable build-in matchit pluggin
runtime macros/matchit.vim

" @nitsas command for skroutz's yogurt github
command! OpenOnGithub execute ('!open "'.CurrentRepoGithubURL().'"')

function! CurrentRepoGithubURL()
  return 'https://github.skroutz.gr/skroutz/yogurt/blob/master/'.expand('%').'\#L'.line('.')
endfunction

" CoC
let g:coc_global_extensions = ['coc-solargraph']
let g:coc_disable_startup_warning = 1

augroup filetype_js
    autocmd!
    autocmd FileType javascript set filetype=javascript
augroup END

" Rainlow
let g:rainbow_active = 1
