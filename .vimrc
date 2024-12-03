" Don't try to be vi compatible
set nocompatible
set nolist
set rnu
set cursorline
" set spell
au TermOpen * setlocal nospell

" Helps force plugins to load correctly when it is turned back on below
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-python/python-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'notpratheek/pychimp-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'skielbasa/vim-material-monokai'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'leafOfTree/vim-svelte-plugin'
" Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()
" Svelte Config
let g:vim_svelte_plugin_use_typescript=1
" set local options based on subtype
function! OnChangeSvelteSubtype(subtype)
  if empty(a:subtype) || a:subtype == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:subtype =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction
" colorscheme codedark
let g:airline_theme = 'codedark'
set background=dark
colorscheme material-monokai
""let g:airline_theme = 'materialmonokai'
let g:materialmonokai_italic=1 " For comments
let g:materialmonokai_subtle_spell=1
let g:materialmonokai_custom_lint_indicators=0
" Coc server extensions
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-deno' , 'coc-json' , 'coc-css' , 'coc-highlight' , 'coc-prettier' , 'coc-eslint', 'coc-html' , 'coc-java' , 'coc-angular' , 'coc-xml', 'coc-go', 'coc-spell-checker' ]
let g:airline_powerline_fonts = 1
autocmd FileType python let b:coc_root_patterns = ['.vim', '.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
let mapleader = " "

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Encoding
set encoding=utf-8

" Whitespace
set wrap
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set noerrorbells
set smartindent

" Cursor motion
set scrolloff=5
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Navigate
noremap <leader>gs :CocSearch <space>
noremap <leader>fs :Files<cr>
noremap <leader>fg :GFiles<cr>
noremap <leader>d :NERDTreeToggle<cr>
noremap <leader>ff :NERDTreeFind<cr>
let g:NERDTreeQuitOnOpen=1
noremap <leader><Esc> :terminal<cr>
noremap <leader>tv :botright vnew <BAR> :terminal<cr>
noremap <leader>th :botright new <Bar> :terminal<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>gc <Plug>(coc-git-chunkinfo)
imap ii <Esc>
tnoremap <Esc> <C-\><C-n>
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>fa  mtggVG<Plug>(coc-format-selected)`t
nmap <leader>fa  mtggVG<Plug>(coc-format-selected)`t
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Spell Check
vmap <leader>a <Plug>(coc-codeaction-selected)<cr>
nmap <leader>a <Plug>(coc-codeaction-selected)<cr>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

" inoremap {  {}<ESC>hli
" inoremap (  ()<ESC>hli
" inoremap "  ""<ESC>hli
" inoremap '  ''<ESC>hli
" inoremap `  ``<ESC>hl
map <leader>jgs mawv/ <CR>"ty/ <CR>wvwh"ny/getters<CR>$a<CR><CR><Esc>xxapublic <Esc>"tpa<Esc>"npbiget<Esc>l~ea() {<CR><Tab>return<Esc>"npa;<CR>}<Esc>=<CR><Esc>/setters<CR>$a<CR><CR><Esc>xxapublic void<Esc>"npbiset<Esc>l~ea(<Esc>"tpa <Esc>"npa) {<CR><Tab>this.<Esc>"npa=<Esc>"npa;<CR>}<Esc>=<CR>`ak
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

" vnoremap <leader>y y:call ClipboardYank()<cr>
" vnoremap <leader>d d:call ClipboardYank()<cr>
" nnoremap <leader>p :call ClipboardPaste()<cr>p

" For vim
" hi MatchParen cterm=underline ctermbg=none ctermfg=none " use it to remove color of matching elements
" For nvim
hi MatchParen cterm=underline ctermbg=none ctermfg=none guifg=none guibg=none gui=underline
" Protobuf support
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
