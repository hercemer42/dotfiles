set nocp

filetype off
call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'fholgado/minibufexpl.vim'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'maralla/completor.vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'heavenshell/vim-jsdoc'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'yuttie/comfortable-motion.vim'
Plug 'jszakmeister/vim-togglecursor'

call plug#end()

filetype plugin indent on

"set t_Co=256
let base16colorspace=256
set termguicolors
let g:onedark_color_overrides = {"black": {"gui": "#1a1a1a", "cterm": "235", "cterm16": "0" }}

colorscheme onedark
set syntax=on
hi VertSplit guifg=bg guibg=bg

set shortmess+=c
set completeopt+=menu,menuone,noinsert
set number " enable line numbers
set showcmd
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set showmatch
set hidden " allow the use of unsaved buffer
set prompt " prompt on saving
set backspace=indent,eol,start " Better handling of backspace key
set nostartofline              " Emulate typical editor navigation behaviour
set dir=/tmp
set nobackup
set backupcopy=yes " When watching things with webpack etc
set autoindent
" Spaces are better than a tab character
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set shiftround
set ignorecase
set incsearch
set smartcase
set spelllang=en
set nospell
set spellsuggest=5
set showmode
set laststatus=2
set hlsearch
set guicursor=i:ver25-iCursor
set nofoldenable
set encoding=utf8
" split more naturally
set splitright
set splitbelow
" highlight current line
set cul
" Configure invisible characters
set nolist
"cd to file cwd
set noautochdir
" wrap to previous line when cursor reach eol/beginning
" set whichwrap+=<,>,h,l,[,]
set nowrap
" Key mapping
" F/T forward backward
noremap ; :
" noremap <lt> ,
noremap , ;
" Mapping space to leader key
map <Space> <Leader>
"semicolons helper
nnoremap <Leader>; A;<esc>
"paste helper
nnoremap <Leader>p :set paste!<CR>
" Replaces tabs with spaces
nnoremap <Leader>t :0,$s/\t/  /g<CR>
vnoremap <Leader>y "+y
vnoremap <Leader>Y "+Y
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
nnoremap <S-L> :MBEbn<CR>
nnoremap <S-H> :MBEbp<CR>
" Delete buffer but leave window open
nnoremap <Leader>q :MBEbd<CR>
" Navigate between splits more naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <S-J> }
nnoremap <S-K> {
vnoremap <S-J> }
vnoremap <S-K> {

" Chdir to current file
let g:NERDTreeChDirMode=1
let g:NERDTreeShowBookmarks=1
" NERDTree window size
let g:NERDTreeWinSize=24
let g:NERDTreeBookmarksFile = $HOME ."/.vim/bundle/nerdtree/bookmarks"
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI=1
" map NERDTree to ' n'
map <Leader>n :NERDTreeToggle<CR>

let g:lock = "🔒""

" Lightline
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ 'component_function': {
\   'filetype': 'MyFiletype',
\   'fileformat': 'MyFileformat',
\ }
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" auto remove/hi trailing space
autocmd BufWritePre * :%s/\s\+$//e

function! CtrlPCommand()
    let c = 0
    let wincount = winnr('$')

    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile

    FZF
endfunction

let g:ctrlp_map = ''
nnoremap <C-p> :call CtrlPCommand()<CR>

" MinBufExpl options
let g:miniBufExplBRSplit=0
let g:miniBufExplCycleArround=1
let g:miniBufExplShowBufNumbers = 0
let g:miniBufExplVSplit = 0

" MiniBufExpl Colors
hi MBENormal               guifg=#a8a8a8 guibg=fg
hi MBEChanged              guifg=#e5c07b guibg=fg
hi MBEVisibleNormal        guifg=#56b6c2 guibg=fg
hi MBEVisibleChanged       guifg=#be5046 guibg=fg
hi MBEVisibleActiveNormal  guifg=#98c379 guibg=fg
hi MBEVisibleActiveChanged guifg=#be5046 guibg=fg

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Ale linters
let g:ale_linters = {
\  'typescript': ['tslint', 'tsserver', 'typecheck'],
\  'javascript': ['eslint'],
\}
let g:ale_sign_column_always = 1

autocmd BufRead,BufNewFile *.ts set filetype=typescript

" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

