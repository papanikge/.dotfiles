" Hacked together by George Papanikolaou.
" Third edition, optimized for Arch Linux

" Must come first because it changes other options.
set nocompatible

silent! call pathogen#runtime_append_all_bundles()

" ------> Basic options <------
" Turn on syntax highlighting.
syntax enable
" Turn on file type detection.
filetype plugin indent on

" Changing the leader to comma
let mapleader = ","

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

" Turn on line wrapping.
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

" Make Esc work faster
set ttimeoutlen=50

" Enhanced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.swp?                           " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python bytecode

" ------> Filetype spesific settings <------
" C (based on the linux kernel guideline)
autocmd FileType c set noexpandtab
" Arduino (for c++)
autocmd BufRead,BufNewFile *.ino set ft=cpp

" ------> Remappings <------
" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

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

" Fix the w-e-b keys
nnoremap w W
nnoremap e E
nnoremap b B

" Fix the Y key
nnoremap Y y$

" Use just the Q to quit
noremap Q :q<CR>

" Use K to split lines
nnoremap K i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" System clipboard
nnoremap gp "+p
nnoremap gy "+y

" Delete without adding to the yank stack
nnoremap <silent> <leader>d "_d

" Fix the 'gd' shortcut
nnoremap gd gD

" Stay in place when hitting *
nnoremap * *N

" the `s` are empty
nnoremap s <nop>

" Set `-` to go to the end of the line (like $)
noremap - $

" make the [{ keys useful
" go to begging/end of current block
nnoremap [[ [{
nnoremap ]] ]}

" Search for word under cursor at the cwd (with external grep)
nnoremap # :!grep <cword> -r -n -I --exclude-dir=.git . <CR>

" ------> Appearence <------
" colorize the collumn
set colorcolumn=80

" GUI options:
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=b
set guioptions-=m
" Font:
set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
" colorscheme solarized
" colorscheme dante
colorscheme badwolf
set t_Co=256

" Folding
set foldenable
set foldlevelstart=99
set foldmethod=syntax               " syntax-based (and indent for python)
au FileType python set foldmethod=indent
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <Space> za
vnoremap <Space> za

" ------> Leader shortcuts <------
" Fast saving
nnoremap <leader>s :w<CR>

" Select all
nnoremap <leader>a ggVG

" Toggle TagBar
nnoremap <leader>b :TagbarToggle<CR>

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

" Diff options
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff!<CR>

" Easily open a new vertical window
nnoremap <leader>v :vnew<CR>

" Switch cwd to the directory of the current buffer
nnoremap <leader>h :cd %:p:h<CR>:pwd<CR>

" Launch the 'text' section of my dropbox
nnoremap <leader>x :cd ~/Dropbox/text<CR>:NERDTreeToggle<CR>

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <leader>w mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Edit the bash aliases (bashrc actually)
nnoremap <leader>ea :e ~/.bashrc<CR>

" Edit the .vimrc file easily
nnoremap <leader>ev :e ~/.vim/.vimrc<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" ------> Auto and plugins <------
" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Abbreviations for correction:
iabbrev teh the
iabbrev adn and
iabbrev hten then

" Powerline settings
let g:Powerline_symbols = 'fancy'

" Ctrl-P
let g:ctrlp_extensions = ['tag']
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 2
let g:ctrlp_max_height = 10
let g:ctrlp_max_depth = 5
nnoremap <c-t> :CtrlPTag<CR>
nnoremap <c-u> :CtrlPMRU<CR>
