" Hacked together by George Papanikolaou.
" Third edition 2013, optimized for Arch Linux

" Must come first because it changes other options.
set nocompatible

silent! call pathogen#runtime_append_all_bundles()

" }----------------------------- Basic options ------------------------------{

" Turn on syntax highlighting.
syntax enable
" Turn on file type detection.
filetype plugin indent on

" Changing the leaders for easy access
let mapleader = ","
let maplocalleader = "|"

" Display incomplete commands.
set showcmd
" Display the mode you're in.
set showmode

" Intuitive backspacing.
set backspace=indent,eol,start

" Handle multiple buffers better.
set hidden

" Case-insensitive searching.
set ignorecase
" But case-sensitive if expression contains a capital letter.
set smartcase

" Show line numbers.
set number
" Show cursor position.
set ruler

" Highlight matches as you type.
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

" Set auto-intend
set ai

" No beeping.
set visualbell

" Don't make a backup before overwriting a file.
set nobackup
" And again.
set nowritebackup

" History and undo levels
set undolevels=400
set history=100

" Hidden characters
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" Lines left when moving vertically
set so=2

" Show the status line all the time
set laststatus=2

" Global tab width.
set tabstop=4
" And again, related.
set shiftwidth=4
" Use spaces instead of tabs
set expandtab
set smarttab

" Delete trailing comment leader when (J)oining lines (requires vim 7.4)
set formatoptions+=j

" Make Esc work faster
set ttimeoutlen=50

" Enhanced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.pdf    " binary images and pdfs
set wildignore+=*.mp3,*.mp4,*.mkv,*.m4a,*.m3u    " music data files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.swp?                           " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python bytecode

" }----------------------- Filetype specific settings -----------------------{

" C (based on the linux kernel guideline)
autocmd FileType c set noexpandtab
" Arduino (for c++)
autocmd BufRead,BufNewFile *.ino set ft=cpp
autocmd BufRead,BufNewFile *.h set ft=c

" }------------------------------- Remappings -------------------------------{

" multiple indentations in visual mode and single stroke in normal mode
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>

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

" Use just the Q to quit
noremap Q :q<CR>

" Use K to split lines (credits to Steve Losh)
nnoremap K i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" System clipboard
nnoremap gy "+y
nnoremap gp o<ESC>"+p
nnoremap gP O<ESC>"+p

" Backspace to visual delete in oblivion
vnoremap <BS> "_d

" more powerful gd shortcut
nnoremap gd :call FindDefinition()<CR>

" Stay in place when hitting *
nnoremap * *N

" format sentence or visual selection
nnoremap \ gq)
vnoremap \ gq

" seeking the best use of the `s` keys
nnoremap s viw
nnoremap S <nop>
vnoremap s S

" Set - to go to the end of the line (like $)
" and 0 to not go to the first character
noremap - $
noremap 0 ^
noremap ^ 0

" make the [{ keys useful
" go to begging/end of current block
nnoremap [[ [{
nnoremap ]] ]}

" Search for word under cursor at the cwd (with external grep)
nnoremap # :Ack!<CR>

" Better tab
nnoremap <tab> %
vnoremap <tab> %

" }------------------------------- Appearance -------------------------------{

" colorize the column
set colorcolumn=80

" GUI options
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=b
set guioptions-=m
set background=dark

" fonts and colors
set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
colorscheme jellybeans
set t_Co=256

" folding
set foldenable
set foldlevelstart=99
set foldmethod=syntax               " syntax-based (and indent for python)
au FileType python set foldmethod=indent
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <Space> za
vnoremap <Space> za
nnoremap zo zR
nnoremap zc zM

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }---------------------------- Leader shortcuts ----------------------------{

" Fast saving
nnoremap <leader>s :w<CR>

" Select all
nnoremap <leader>a ggVG

" Toggle TagBar
nnoremap <leader>b :TagbarToggle<CR>

" Toggle paste mode
nnoremap <leader>p :set paste!<CR>

" No Highlighted search
nnoremap <leader>n :nohlsearch<CR>

" Open the NERDTRee plugin
nnoremap <leader>t :NERDTree<CR>

" Why am I just learning about Gundo?
nnoremap <leader>g :NERDTreeClose<CR>:GundoToggle<CR>

" Show registers
nnoremap <leader>r :registers<CR>

" Show marks
nnoremap <leader>m :marks<CR>

" Show invisible characters
nnoremap <leader>c :set list!<CR>

" Capitalize the whole document
nnoremap <leader>C :%s/\<./\u&/g<CR>:noh<CR>

" Remove trailing whitespace
nnoremap <leader>z :%s/\s\+$//e<CR>:nohlsearch<CR>

" Delete without adding to the yank stack
nnoremap <silent> <leader>d "_d

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Easily open a new vertical window
nnoremap <leader>v :vnew<CR><C-W>L

" Switch cwd to the directory of the current buffer
nnoremap <leader>h :cd %:p:h<CR>:pwd<CR>

" Launch the 'text' section of my dropbox
nnoremap <leader>x :cd ~/Dropbox/text<CR>:NERDTreeToggle<CR>

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <leader>w mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Diff options
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff!<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

" Easy edit
nnoremap <leader>ea :e ~/.bashrc<CR>
nnoremap <leader>ev :e ~/.vim/.vimrc<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <m-b> <S-left>
cnoremap <m-f> <S-right>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null<CR>

" }---------------------------- Auto and plugins ----------------------------{

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Abbreviations for correction and ease
iabbrev teh the
iabbrev adn and
iabbrev hten then
cabbrev h vert bo help

" Powerline settings
let g:Powerline_symbols = 'fancy'

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
autocmd WinEnter * call s:CloseUnwanted()

" Ack (with the silver searcher)
let g:ackprg = 'ag --nogroup --nocolor --column'

" Don't fold by default
let g:vim_markdown_folding_disabled = 1

" }------------------------------- Functions --------------------------------{

" close quickfix on leaving and NERDTree buffer when is the only one left
function! s:CloseUnwanted()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
    if getbufvar(winbufnr(winnr("#")), "&buftype") == "quickfix"
        q
    endif
endfunction

" find function definition globally if there is a tags file
function! FindDefinition()
    try
        silent! execute 'tag' expand('<cword>')
        normal zt
    catch
        normal gD
        nohlsearch
    endtry
endfunction
