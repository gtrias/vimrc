" Genar Vim Settings
"
"
"
" General settings
set nocompatible
set encoding=utf-8
set autowrite
set timeoutlen=500
set hidden
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Folding settings
set foldmethod=indent
set foldnestmax=15
set nofoldenable
set foldlevel=1

" Indent settings
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

" Gui settings
set number
set ruler
set t_Co=256
set laststatus=2
set statusline=%F\ \%{fugitive#statusline()}\ \%=\ \%y\ -\ %l/%L
call neobundle#begin(expand('/home/genar/.vim/bundle'))

" Neobundle magic
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
	  \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'lokaltog/vim-easymotion'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'groenewege/vim-less'
NeoBundle 'ciaranm/detectindent'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'evidens/vim-twig'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/powerline',{'rtp': 'powerline/bindings/vim/'}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'm2mdas/phpcomplete-extended'
NeoBundle 'm2mdas/phpcomplete-extended-symfony'
NeoBundle 'm2mdas/phpcomplete-extended-laravel'
NeoBundle 'chriskempson/vim-tomorrow-theme'

NeoBundleCheck

call neobundle#end()


" Sets current directory every time we open a buffer
autocmd BufEnter * silent! lcd %:p:h

" phpcomplete settings
let g:phpcomplete_index_composer_command="composer"

" gitgutter settings
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = 'MM'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = 'M-'

filetype plugin indent on


" Vimshell tunning
let g:vimshell_prompt_expr =
        \ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
        let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '


filetype plugin indent on

colorscheme torte
highlight LineNr ctermfg=darkgrey
highlight SignColumn ctermbg=black
highlight Folded ctermfg=11 ctermbg=23


"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

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

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Persistent undo
" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=/home/genar/.vimundo/

autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP

"vim easymotion
map <Leader> <Plug>(easymotion-prefix)
