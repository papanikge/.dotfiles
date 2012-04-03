" Hacked together by George Papanikolaou.
" Original by Andrew Stewart

set nocompatible                  " Must come first because it changes other options.

silent! call pathogen#runtime_append_all_bundles()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

let mapleader = ","               " Changing the leader to comma

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch

set wrap                          " Turn on line wrapping.

set title                         " Set the terminal's title

set autoread                      " Set to auto read when a file is changed from the outside

set ai                            " Set auto-intend

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set undolevels=100                 " History and undo levels
set history=100

set tabstop=4                    " Global tab width.
set shiftwidth=4                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set smarttab

set foldmethod=manual            " syntax folding

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

set laststatus=2                  " Show the status line all the time

" Useful status information at bottom of screen
" set statusline=[%n]\\ %<%.99f\\ %h%w%m%r%y\\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\\ %l,%c-%v\\ %)%P

set undodir=~/.vim/tmp/undo/     " undo files directory if available

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
map Y y$

" GUI options:
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" fonts and sizes: check Inconsolata
set guifont=Monaco:h12

if has('gui_running')
    set background=light
else
    set background=dark
endif

colorscheme jellybeans  " Or emacs or solarized
set t_Co=256

" Toggle TagBar
nnoremap <leader>tb :TagbarToggle<CR>
" Open a scratch buffer
nnoremap <leader>s :Scratch<CR>
" No Highlighted search
nnoremap <leader>nh :nohlsearch<CR>
" Open the NERDTRee plugin
nnoremap <leader>nt :NERDTreeToggle<CR>
" Show registers
nnoremap <leader>r :registers<CR>
" Capitalize the whole document
nnoremap <leader>C %s/\<./\u&/g<CR>
" Show Invisible characters
nnoremap <leader>i :set list!<CR>

" Use just the Q to :wq
noremap Q ZQ

" Return to normal mode on FocustLost
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Edit the .vimrc file easily
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Edit the bash aliases
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.bash/aliases<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Abbreviations for correction:
iabbrev teh the
iabbrev adn and
iabbrev hten then

" Personal abbreviations:
iabbrev mmu papanikge@ceid.upatras.gr
iabbrev llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iabbrev ccopy ©

" Powerline settings
let g:Powerline_symbols = 'fancy'

" Command-T settings
let g:CommandTMaxFiles=5000
let g:CommandTMaxHeight=12
map <C-p> :CommandT<CR>
let g:CommandTAcceptSelectionMap = '<CR>'

" Vim-Slime setting to tmux
let g:slime_target = "tmux"
