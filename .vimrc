" Hacked together by George 'papanikge' Papanikolaou.
" Third-ish version 2013-5, optimized for Linux

" First, move to no-old-vi-compatible mode and activate bundles
set nocompatible
execute pathogen#infect()

let os = substitute(system('uname'), "\n", "", "")

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

" New (>7.4) vim features. Hybrid number mode and smart line joining
if v:version >= 704
  set relativenumber
  set formatoptions+=j
endif
set number
" Show cursor position
set ruler

" Highlight matches as you type
set incsearch
set hlsearch

" Don't continue at top when searching
set nowrapscan

" Don't wrap
set nowrap

" Set the terminal's title
set title

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

" Line margin when moving vertically
set scrolloff=2

" Show the status line all the time
set laststatus=2

" Tabs. With spaces
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Make Esc work faster
set ttimeoutlen=50

" Look up the tree for tags file
set tags=./tags;/

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

" }------------------------------- Appearance -------------------------------{

" Colorize the column
set colorcolumn=80

if has("gui_running")
  colorscheme tomorrow-night
  if os == "Linux"
    set guifont=Menlo\ for\ Powerline\ 9
  else
    set guifont=Inconsolata\ for\ Powerline:h14
  endif
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=b
  set guioptions-=m
else
  colorscheme jellybeans
endif

" Folding
set foldenable
set foldlevelstart=99
set foldmethod=syntax               " syntax-based (and indent for python)
autocmd FileType python,haskell setlocal foldmethod=indent
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <Space> za
vnoremap <Space> za
nnoremap zo zR
nnoremap zc zM
nnoremap zO zCzO

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }------------------------------- Remappings -------------------------------{

" Multiple indentations in visual mode and single stroke in normal mode
" removed << remappings in normal mode because they were useless because of
" the different < mappings. (e.g. <, to shift function arguments)
vnoremap < <gv
vnoremap > >gv

" Make pasting smarter in visual mode
vnoremap p p:let @"=@0<CR>

" Use the Goddamn HJKL keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

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
noremap Q :q<CR>

" Use K to split lines (credits to Steve Losh)
nnoremap K i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" System clipboard (linux tested only)
nnoremap gy "+y
nnoremap gp o<ESC>"+p
nnoremap gP O<ESC>"+p

" Backspace to visual delete in oblivion
vnoremap <BS> "_d

" More powerful gd shortcut
nnoremap gd :call FindDefinition()<CR>

" Stay in place when hitting *
nnoremap * *N

" format sentence or visual selection
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

" Search for word under cursor at the cwd (with external grep)
nnoremap # :Ack!<CR>

" Use ? for substitution. I never use it to search backwards anyway
nnoremap ? :%s/<C-R><C-W>//g<left><left>

" }---------------------------- Leader shortcuts ----------------------------{

" Fast saving
nnoremap <leader>s :w<CR>

" Select all
nnoremap <leader>a ggVG

" Toggle TagBar
nnoremap <leader>b :TagbarToggle<CR>

" Select (last?) pasted text
nnoremap <leader>p `[v`]

" No Highlighted search
nnoremap <leader><Space> :nohlsearch<CR>

" Open the NERDTRee plugin
nnoremap <leader>t :NERDTree<CR>

" Why am I just learning about Gundo?
nnoremap <leader>g :NERDTreeClose<CR>:GundoToggle<CR>

" Show registers
nnoremap <leader>r :registers<CR>

" Show marks
nnoremap <leader>m :marks<CR>

" Show invisible characters
nnoremap <leader>c :set list!<CR>:IndentLinesToggle<CR>

" Remove trailing whitespace
nnoremap <leader>z :%s/\s\+$//e<CR>:nohlsearch<CR>

" Toggle between wrapping
nnoremap <leader>l :set wrap!<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

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

" Easy edit. Useless because of ctrl-p but I'm used to them
nnoremap <leader>eb :e ~/.bashrc<CR>
nnoremap <leader>ea :e ~/.aliases<CR>
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>eg :e ~/.gitconfig<CR>
nnoremap <leader>ex :e ~/.xmonad/xmonad.hs<CR>
nnoremap <leader>x :cd ~/Dropbox/text<CR>:NERDTreeToggle<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <m-b> <S-left>
cnoremap <m-f> <S-right>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null<CR>

" }---------------------------- Auto and plugins ----------------------------{

" Commands to be ran on every buffer every time
autocmd BufEnter * call LoadCscopeFile()

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Mail
autocmd BufRead,BufNewFile *mutt-* setlocal ft=mail cc=72

" Enable spelling to specific text filetypes
autocmd Syntax mail,mkd setlocal spell

" Use pandoc as a formatter when editing html
let pandoc_pipeline  = "pandoc --from=html --to=markdown"
let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
autocmd FileType html let &formatprg=pandoc_pipeline

" Enable rainbow parentheses for lisp-like languages and <> for c++'s templates
autocmd FileType lisp,clojure,scheme,cpp RainbowParenthesesActivate
autocmd Syntax lisp,clojure,scheme RainbowParenthesesLoadRound
autocmd Syntax cpp RainbowParenthesesLoadChevrons

" Abbreviations for correction and ease
iabbrev teh the
iabbrev adn and
iabbrev hten then
cabbrev h vert bo help

" Powerline with the light-weight airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

" Ctrl-P
let g:ctrlp_extensions = ['tag']
let g:ctrlp_switch_buffer = 2
let g:ctrlp_max_height = 10
let g:ctrlp_max_depth = 5
let g:ctrlp_clear_cache_on_exit = 0
nnoremap <c-t> :CtrlPTag<CR>
nnoremap <c-u> :CtrlPMRU<CR>

" NERD_Tree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeHighlightCursorline = 1
autocmd WinEnter * call CloseUnwanted()

" Ack (with the silver searcher)
let g:ackprg = 'ag --nogroup --nocolor --column'

" Don't fold by default
let g:vim_markdown_folding_disabled = 1

" Default browser
let g:netrw_browsex_viewer= "chromium"

" Don't show the indent lines by default
let g:indentLine_enabled = 0

" Tagbar show only public entries. (Toggle with 'h')
let g:tagbar_hide_nonpublic = 1

" }------------------------------- Functions --------------------------------{

" Close quickfix on leaving and NERDTree buffer when is the only one left
function! CloseUnwanted()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
  if getbufvar(winbufnr(winnr("#")), "&buftype") == "quickfix"
    wincmd p
    close
  endif
endfunction

" Find function definition globally if there is a tags file
function! FindDefinition()
  try
    cscope find g <cword>
  catch
    try
      tag
      normal zt
    catch
      normal gD
      nohlsearch
    endtry
  endtry
endfunction

" Add any cscope database in the current directory
function! LoadCscopeFile()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
