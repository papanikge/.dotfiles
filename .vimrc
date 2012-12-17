" Hacked together by George Papanikolaou.
" Third edition, optimized for Arch Linux

" Must come first because it changes other options.
set nocompatible

silent! call pathogen#runtime_append_all_bundles()

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

" Enhanced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest

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

" Turn on line wrapping.
set nowrap

" Set the terminal's title
set title

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
" Keep swap files in one location
set directory=$HOME/.vim/tmp//,.

" History and undo levels
set undolevels=300
set history=100

" Global tab width.
set tabstop=4
" And again, related.
set shiftwidth=4
" Use spaces instead of tabs
set expandtab
set smarttab

" syntax folding
set foldmethod=manual

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Show the status line all the time
set laststatus=2

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

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

" Use just the Q to :wq
noremap Q ZQ

" Use K to split lines
nnoremap K i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" System clipboard
nnoremap gp "+p
nnoremap gy "+y

" make the [{ keys useful
" go to begging/end of current block
nnoremap [[ [{
nnoremap ]] ]}

" colorize the collumn
set colorcolumn=80

" Set `-` to go to the end of the line (like $)
noremap - $

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
" colorscheme:
colorscheme badwolf
set t_Co=256

" Toggle TagBar
nnoremap <leader>b :TagbarToggle<CR>

" No Highlighted search
nnoremap <leader>n :nohlsearch<CR>

" Open the NERDTRee plugin
nnoremap <leader>t :NERDTreeToggle<CR>

" Why am I just learning about Gundo?
nnoremap <leader>g :GundoToggle<CR>

" Show registers
nnoremap <leader>r :registers<CR>

" Show marks
nnoremap <leader>m :marks<CR>

" Show Invisible characters
nnoremap <leader>i :set list!<CR>

" Capitalize the whole document
nnoremap <leader>C :%s/\<./\u&/g<CR>

" Remove trailing whitespace
nnoremap <leader>z :%s/\s\+$//e<CR>

" Diffoff
nnoremap <leader>d :diffoff!<CR>

" Easily open a new vertical window
nnoremap <leader>v :vnew<CR>

" Launch the 'text' section of my dropbox
nnoremap <leader>x :cd ~/Dropbox/text<CR>:NERDTreeToggle<CR>

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <leader>w mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Edit the bash aliases
nnoremap <leader>ea :e ~/.bash/aliases<CR>

" Edit the .vimrc file easily
nnoremap <leader>ev :e ~/.vim/.vimrc<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Easy access to man pages with Ref plugin
cnoremap man Ref man

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Abbreviations for correction:
iabbrev teh the
iabbrev adn and
iabbrev hten then

" Ctrl-P
let g:ctrlp_user_command = 'find %s -type f'

" Powerline settings
let g:Powerline_symbols = 'fancy'
