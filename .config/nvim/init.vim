call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
call plug#end()
set nocompatible
set t_Co=256
nmap о j
nmap л k
nmap р h
nmap д l
nmap ш i
nmap ф a
nmap в d
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
set number
set ruler
