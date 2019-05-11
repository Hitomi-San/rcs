set nocompatible
syntax on
filetype plugin indent on
set undofile
set mouse=a
set ttymouse=xterm2
set autoindent
set smartindent

"カーソルライン
set number
set cursorline

"ホイールスクロール
map <ScrollWheelUp> <Up>
map <ScrollWheelDown> <Down>
map! <ScrollWheelUp> <Up>
map! <ScrollWheelDown> <Down>
set belloff=cursor,error

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
set listchars=tab:^\ ,space:␣
"カラーリング
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight Normal ctermfg=none
autocmd ColorScheme * highlight LineNr ctermfg=8
autocmd ColorScheme * highlight CursorLine ctermbg=0
autocmd ColorScheme * highlight CursorLine ctermfg=none
autocmd ColorScheme * highlight Visual ctermbg=1
autocmd ColorScheme * highlight Visual ctermfg=none
autocmd ColorScheme * highlight SpecialKey ctermfg=8
colorscheme molokai

""""https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
""""""""""""""""""""""""""""""
"全角スペースを表示
""""""""""""""""""""""""""""""

"デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif
