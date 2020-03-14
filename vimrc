" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}


" dein installation check {{{
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}


" begin settings {{{
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)


    " .toml file
    let s:rc_dir = expand('~/.vim')
    if !isdirectory(s:rc_dir)
        call mkdir(s:rc_dir, 'p')
    endif
    let s:toml = s:rc_dir . '/dein.toml'


    " read toml and cache
    call dein#load_toml(s:toml, {'lazy': 0})


    " end settings
    call dein#end()
    call dein#save_state()
endif
" }}}


" plugin installation check {{{
if dein#check_install()
    call dein#install()
endif
" }}}


" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
" }}}
"-------------------------------------------------------

"vim-lsp-setting vim-plug
call plug#begin('~/.vim/plugged')

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

call plug#end()


"スペースをリーダーキーに設定
let mapleader = "\<Space>"
"行番号を表示する
set number
"編集中のファイル名を表示
set title

 "括弧入力時の対応する括弧を表示
set showmatch

 "コードの色分け
syntax enable

"color
"colorscheme iceberg
colorscheme allomancer

"インデントをスペース2つ分に設定
set shiftwidth=2 

" タブでも常に空白を挿入
set tabstop=2
set expandtab

"改行時に自動インデント
set smartindent 
set autoindent

" 行末の空白を表示する
set list
set listchars=trail:·
highlight ExtraWhitespace ctermfg=darkgreen guifg=darkgreen
" 半角，タブ
" match ExtraWhitespace /\s\+$/
" 半角スペースのみ
match ExtraWhitespace / \+$/

" ファイル形式別プラグインとインデントを有効にする
filetype plugin indent on

" 拡張子ごとのインデントを指定する
augroup fileTypeIndent
    autocmd!
    au BufRead,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
    au BufRead,BufNewFile *.html setlocal tabstop=4 softtabstop=4 shiftwidth=4
    au BufRead,BufNewFile *.js   setlocal tabstop=2 softtabstop=2 shiftwidth=4
    au BufRead,BufNewFile *.vue  setlocal tabstop=4 softtabstop=4 shiftwidth=4
    au BufRead,BufNewFile *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
augroup END

" バックスペースとCtrl+hで削除を有効にする 
set backspace=2
 
" 行を強調表示
set cursorline

" 列を強調表示
"set cursorcolumn

 "大文字/小文字の区別なく検索する
set ignorecase

 "検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"検索時に最後まで行ったら最初に戻る
set wrapscan 

"マウス操作許可
set mouse=a

"ノーマルモードでエンター改行
"nnoremap <CR> i<Return><Esc>^k

"エスケープJJ
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>

"一つ前のタブに移動
nnoremap gr gT<CR>

"Vaffleをスペース f で起動
nnoremap <leader>f :Vaffle<CR>

"新しいタブをスペース tで起動
nnoremap <leader>t :tabnew<CR>

" 日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

" mac os のクリップボードを共有
set clipboard+=unnamed

" カーソルが常に中央に来るようにする
set scrolloff=100

"#lightline-vim
set laststatus=2
set t_Co=256
set noshowmode
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"#vimcolor-24bi
if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"insert時にemacs移動
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>


" fzf settings {{{
" ファイル一覧を出すときにプレビュー表示
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <C-P> :Files<CR>

"tigをvimで呼び出す
nnoremap tig :<C-u>w<CR>:te tig<CR>
