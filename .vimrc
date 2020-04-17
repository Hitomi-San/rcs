lang C
set nocompatible
syntax on
filetype plugin indent on
set mouse=a
set ttymouse=xterm2
set autoindent
set smartindent
set backspace=indent,eol,start

"コマンド補完
set wildmenu
set wildmode=longest:full,full

"undo ファイル
set undofile
set undodir=~/.vimundo

"カーソルライン
set number
set cursorline

"ホイールスクロール
map <ScrollWheelUp> <Up>
map <ScrollWheelDown> <Down>
map! <ScrollWheelDown> <Down>
map! <ScrollWheelUp> <Up>
set belloff=cursor,error

"インデント折りたたみ
set foldmethod=indent

"ステータスライン
set statusline=%F
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=[ENC=%{&fileencoding}]
set statusline+=[LOW=%l/%L]
set laststatus=2

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,space:⋅

"カラーリング
"autocmd ColorScheme * highlight Normal ctermbg=none
"autocmd ColorScheme * highlight Normal ctermfg=none
"autocmd ColorScheme * highlight LineNr ctermfg=8
"autocmd ColorScheme * highlight CursorLine ctermbg=0
"autocmd ColorScheme * highlight CursorLine ctermfg=none
"autocmd ColorScheme * highlight Visual ctermbg=1
"autocmd ColorScheme * highlight Visual ctermfg=none
"autocmd ColorScheme * highlight SpecialKey ctermfg=8
autocmd ColorScheme * highlight SpecialKey ctermbg=none
"autocmd ColorScheme * highlight Folded ctermbg=239
"colorscheme molokai
set background=dark
colorscheme solarized

"オムニ補完
let g:deoplete#enable_at_startup = 1
setlocal omnifunc=syntaxcomplete#Complete

"vim-plug
call plug#begin()
	Plug 'lervag/vimtex'
	Plug 'altercation/vim-colors-solarized'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'yami-beta/asyncomplete-omni.vim'
	Plug 'Shougo/neocomplete.vim'
call plug#end()

"neocomplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"http://blog.basyura.org/entry/20100622/p1
" 補完候補の数
let g:neocomplete#max_list = 5
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

"vimtex 連携
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
      \ g:vimtex#re#neocomplete
