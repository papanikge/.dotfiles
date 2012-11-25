" Hacked together by George Papanikolaou.
" Original by Andrew Stewart
" THIS IS THE LINUX EDITION (Debian)

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

set nowrap                        " Turn on line wrapping.

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

" Use just the Q to :wq
noremap Q ZQ

" Use K to split lines
nnoremap K i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" System clipboard
nnoremap gp "+p
nnoremap gy "+y

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

" Show registers
nnoremap <leader>r :registers<CR>
" Show marks
nnoremap <leader>m :marks<CR>

" Show Invisible characters
nnoremap <leader>i :set list!<CR>

" Capitalize the whole document
nnoremap <leader>C %s/\<./\u&/g<CR>

" Diffoff
nnoremap <leader>d :diffoff!<cr>

" Launch the "Elements" notes
nnoremap <leader>e :cd ~/Dropbox/Elements<CR>:NERDTreeToggle<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Remove the 'Windows' ^M - when the encodings gets messed up
noremap <Leader>w mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Edit the bash aliases
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.bash/aliases<CR>
" Edit the .vimrc file easily
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" Abbreviations for correction:
iabbrev teh the
iabbrev adn and
iabbrev hten then

" Ctrl-P
let g:ctrlp_user_command = 'find %s -type f'

" Powerline settings
let g:Powerline_symbols = 'fancy'
