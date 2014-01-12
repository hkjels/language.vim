
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
  NeoBundleLazy 'eagletmt/neco-ghc', { 'autoload': { 'filetypes': ['haskell'] } }
  NeoBundleLazy 'osyo-manga/vim-marching', { 'autoload': { 'filetypes': ['c', 'cpp'] } }
  NeoBundle 'scrooloose/syntastic'          " Syntax-check / error reporting
  NeoBundle 'Shougo/context_filetype.vim'   " Wrap language-type in any file
  NeoBundle 'osyo-manga/vim-watchdogs'      " Async syntax-highlighting, includes whole bunch of languages
  NeoBundleLazy 'chrisbra/csv.vim', { 'autoload': { 'filetypes': ['csv', 'dat', 'dsv'] } }
  NeoBundleLazy 'digitaltoad/vim-jade', { 'autoload': { 'filetypes': ['jade'] } }
  NeoBundleLazy 'jcf/vim-latex', { 'autoload': { 'filetypes': ['tex'] } }
  NeoBundleLazy 'guileen/vim-node', { 'autoload': { 'filetypes': ['js'] } }
  NeoBundleLazy 'plasticboy/vim-markdown', { 'autoload': { 'filetypes': ['md', 'markdown', 'mdown', 'mkd'] } }
  NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': ['sass', 'scss', 'haml'] } }
  NeoBundleLazy 'wavded/vim-stylus', { 'autoload': { 'filetypes': ['styl'] } }
  NeoBundleLazy 'AnsiEsc.vim', { 'autoload': { 'filetypes': ['color', 'ansi', 'esc'] } }
  NeoBundleLazy 'html5.vim', {'autoload': {'filetypes': ['html']}}
  NeoBundleLazy 'osyo-manga/unite-highlight', {'autoload': {'unite_sources': ['highlight']}}
" }}}

" Completion ----------------------------------------------------------- {{{
  let s:bundle = neobundle#get('neocomplete')
  function! s:bundle.hooks.on_source(bundle)
    let g:acp_enableAtStartup=0
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#enable_smart_case=1

    " C completion
    let g:marching_clang_command="/usr/bin/clang"
    let g:marching_enable_neocomplete=1
    let g:marching_clang_command_option="-std=c++1y"
    imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

    " Snippet plugin key-mappings.
    " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <silent><expr><TAB> neosnippet#expandable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
      \ "\<C-e>" : "\<TAB>")
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns={}
    endif
    let g:neocomplete#sources#omni#input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#sources#omni#input_patterns.php='[^. \t]->\h\w*\|\h\w*::'
  endfunction
  unlet s:bundle
" }}}


" Languages ------------------------------------------------------------ {{{
  au FileType html set matchpairs+=<:>
  " Syntastic
  let s:bundle = neobundle#get('syntastic')
  function! s:bundle.hooks.on_source(bundle)
    set laststatus=2
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_jump=0
  endfunction
  unlet s:bundle
" }}}

