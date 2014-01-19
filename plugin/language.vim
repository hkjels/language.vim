
"
" Language vim
" ============
"
" Author: Henrik Kjelsberg <hkjels@me.com> (http://take.no/)
" Version: 0.0.1
"
" TODO Make context_filetype execute properly
"

if exists('g:loaded_language')
  finish
else
  let g:loaded_language = 1
endif

augroup filetypedetect
  au BufNewFile,BufRead *.conf set filetype=apache
  au BufNewFile,BufRead *.{scss,sass} set filetype=sass
  au BufNewFile,BufRead *.{color,ansi,esc} set filetype=colored
  au BufNewFile,BufRead *.{md,markdown,mdown,mkd} set filetype=markdown
  au BufNewFile,BufRead *.hs set filetype=haskell
augroup END

" Module dependencies -------------------------------------------------- {{{
  NeoBundle 'Shougo/neocomplete', { 'depends': [
    \   'Shougo/neosnippet.git',
    \   ['rstacruz/sparkup', {'rtp': 'vim', 'autoload': { 'filetypes': ['html'] }}],
    \   'honza/vim-snippets'
    \ ]}
  NeoBundle 'Raimondi/delimitMate'          " Add end-delimiters
  NeoBundle 'tsaleh/vim-align'              " Align by specified character(s)
  NeoBundle 'tpope/vim-commentary'          " Quickly comment/un-comment
  NeoBundle 'tpope/vim-endwise'             " Adds ending to blocks
  NeoBundle 'tpope/vim-ragtag'              " Simplify html/xml-editing
  NeoBundle 'tpope/vim-speeddating'         " Quick incrementation of a variety of values
  NeoBundle 'tpope/vim-surround'            " Surround text with specified delimiter
  NeoBundle 'scrooloose/syntastic'          " Syntax-check / error reporting
  NeoBundle 'Shougo/context_filetype.vim'   " Wrap language-type in any file
  NeoBundle 'osyo-manga/vim-watchdogs'      " Async syntax-highlighting, includes whole bunch of languages
  NeoBundleLazy 'kana/vim-textobj-user'     " Customized text-objects
  NeoBundleLazy 'marijnh/tern_for_vim', {
    \   'build': {'mac': 'npm install'},
    \   'autoload': {
    \     'functions': ['tern#Complete', 'tern#Enable'],
    \     'filetypes': ['javascript'],
    \   }
    \ }                                     " JavaScript completion/refactoring/documentation etc
  NeoBundleLazy 'eagletmt/neco-ghc', {
    \   'autoload': { 'filetypes': ['haskell'] }
    \ }                                     " Haskell completions
  NeoBundleLazy 'osyo-manga/vim-marching', {
    \   'autoload': { 'filetypes': ['c', 'cpp'] } 
    \ }                                     " C completions
  NeoBundleLazy 'chrisbra/csv.vim', {
    \   'autoload': { 'filetypes': ['csv', 'dat', 'dsv'] } 
    \ }                                     " Csv editing helpers
  NeoBundleLazy 'guileen/vim-node', {
    \   'autoload': { 'filetypes': ['js'] }
    \ }                                     " Node.js completion
  NeoBundleLazy 'plasticboy/vim-markdown', {
    \   'autoload': { 'filetypes': ['md', 'markdown', 'mdown', 'mkd'] }
    \ }                                     " Markdown syntax-files
  NeoBundleLazy 'tpope/vim-haml', {
    \   'autoload': { 'filetypes': ['sass', 'scss', 'haml'] }
    \ }                                     " Haml syntax files
  NeoBundleLazy 'AnsiEsc.vim', {
    \   'autoload': { 'filetypes': ['color', 'ansi', 'esc'] }
    \ }                                     " View ansi-escaped files in it's original color
  NeoBundleLazy 'osyo-manga/unite-highlight', {
    \   'autoload': {'unite_sources': ['highlight']}
    \ }                                      " Preview vim colors
  NeoBundleLazy 'othree/html5.vim', {
    \   'autoload': { 'filetypes': ['html']}
    \ }                                      " HTML5 syntax files
" }}}

" Completion ----------------------------------------------------------- {{{
  let g:acp_enableAtStartup=0
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#enable_smart_case=1

  " C completion
  let g:marching_clang_command="/usr/bin/clang"
  let g:marching_enable_neocomplete=1
  let g:marching_clang_command_option="-std=c++1y"
  imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  au FileType html set matchpairs+=<:>

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns={}
  endif
  let g:neocomplete#sources#omni#input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#sources#omni#input_patterns.php='[^. \t]->\h\w*\|\h\w*::'

  " JavaScript completion
  let g:neocomplete#sources#omni#functions=get(g:, 'neocomplete#sources#omni#functions', {})
  let g:neocomplete#sources#omni#functions.javascript='tern#Complete'

  " Syntastic
  set laststatus=2
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_jump=0
" }}}

