set nocompatible

if !exists("syntax_on")
   syntax on
endif

call pathogen#infect()

set sessionoptions-=options

"==========================
" 字体与外观           {{{1
"==========================

function! My256()
    set t_Co=256
    source ~/.vim/bundle/vim-css-color/after/syntax/css.vim
    colorscheme molokai
    hi VisualNOS ctermbg=239
    hi Visual ctermbg=238
    hi Normal ctermbg=none
    hi NonText ctermbg=none
    hi LineNr ctermbg=none
    hi Pmenu ctermbg=none
    hi Special ctermbg=none
endfunction

set mouse=a
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:>-,trail:-
set autoindent
set backspace=2
set whichwrap=b,s,<,>,[,],h
set cino=:0g0t0
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936,gb18030,euc-jp,shift-jis
set nu
set hlsearch
set rulerformat=%55(%{strftime('%b%e日\ 星期%a\ %p\ %I:%M:%S\')}\ %5l,%-6(%c%V%)\ %P%)
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=0
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment

if (has("gui_running"))
    set guifont=Monaco\ 11.5
    set guifontwide=方正准圆\ 11.5
    "Droid\ Sans\ Mono\ 11.5
    "colorscheme koehler
    "colorscheme solarized
    "colorscheme rootwater
    colorscheme molokai
    set mousemodel=popup
    set guioptions-=T
    set guioptions-=m
    set guitablabel=%M%N\ %10.13f
    set columns=100
    set lines=32
else
    "colorscheme desert
    set timeoutlen=300
    set ttimeoutlen=100
    "set t_Co=32
    call My256()
endif

" }}}1

"==========================
" 文件类型支持         {{{1
"==========================

filetype on
filetype plugin on

if has("autocmd")
    "80列后高亮
    "set textwidth=80
    "set cc=+1
    if v:version >= 703
        set cc=80
    else
        au BufRead,BufNewFile * match DiffAdd '\%>80v.*'
    endif
    ""au BufRead,BufNewFile *.c,*.cpp,*.py match Underlined /.\%81v/
    ""au BufRead,BufNewFile *.c,*.cpp,*.py match Error /\%80v.\%81v./

    augroup filetypedetect
        au BufNewFile,BufRead *.ks set filetype=python
        au BufNewFile,BufRead *.hip set filetype=python
        au BufNewFile,BufRead *.kt set filetype=html
        au BufNewFile,BufRead *.pih set filetype=html
        au BufNewFile,BufRead *.html.erb set filetype=html.eruby
    augroup END

    filetype plugin indent on
    set completeopt=longest,menu
    au FileType c set omnifunc=ccomplete#Complete
    au FileType c set fdm=syntax
    au FileType cpp set fdm=syntax
    au FileType python setlocal et | setlocal sta | setlocal sw=4
    au FileType python compiler pyunit
    au FileType python setlocal makeprg=python\ %
    au FileType python set fdm=indent
    let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
    au FileType python set omnifunc=pythoncomplete#Complete
    au FileType ruby set fdm=syntax
    au FileType lisp set et
    au FileType lisp set fdm=marker
    au FileType lisp set fmr=(,)
    au FileType tex set et
    au FileType javascript set omnifunc=javascrīptcomplete#CompleteJS
    au FileType html set omnifunc=htmlcomplete#CompleteTags
    au FileType css set omnifunc=csscomplete#CompleteCSS
    au FileType xml set omnifunc=xmlcomplete#CompleteTags
    au FileType php set omnifunc=phpcomplete#CompletePHP

    au BufWritePost * filet detect
endif

" }}}1

"==========================
" Markdown设置         {{{1
"==========================
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction
if has("autocmd")
    au FileType markdown set et
    au BufEnter *.md setlocal foldexpr=MarkdownLevel()
    au BufEnter *.md setlocal foldmethod=expr
endif

" }}}1

"==========================
" 按键映射             {{{1
"==========================
let mapleader=','
nmap da :s/\s\+$//<CR>
map <C-h> :noh<cr>
nmap <C-s> :w<cr>
nmap <C-q> :q<cr>

map <silent> <leader>1 :tabprev<cr>
map <silent> <leader>2 :tabnext<cr>
map <silent> <leader>w :w<cr>
map <silent> <leader>q :q<cr>
nmap <leader>m :make<CR>
nmap <leader>c :cd %:p:h<CR>
nmap <leader>v :24Vexplore<cr>
nmap <leader>term :ConqueTermTab bash<cr>
nmap <leader>py :ConqueTermTab ipython<cr>

map <silent> <leader>vv :source ~/.vimrc<CR>
map <silent> <leader>vs :source %<CR>

nmap <leader>p :SyntasticCheck<CR>
nmap <leader>ps :SyntasticToggleMode<CR>

map <silent> <leader>sl :SessionList<CR>
"map <silent> <leader>so :SessionOpenLast<CR>
map <silent> <leader>ss :SessionSave<CR>
map <silent> <leader>sa :SessionSaveAs<CR>

map <silent> <leader>gw :Gwrite<CR>
map <silent> <leader>gs :Gstatus<CR>
map <silent> <leader>gc :Gcommit<CR>
map <silent> <leader>gd :Git diff HEAD<CR>

nmap t1 :set t_Co=32<CR>
nmap t2 :call My256()<CR>

nnoremap <silent> <F2> :TocdownToggle<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
"nnoremap <silent> <F8> :Tlist<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
"nmap <silent> <F9> :Explore<cr>

nnoremap <silent> <leader>bb :BufExplorerVerticalSplit<CR>
nmap <C-S-n> :bn<cr>
nmap <C-S-p> :bp<cr>
nmap <C-S-k> :bd<cr>
nmap <C-l> :ls<cr>

nmap <S-t> :tabnew<cr>
nmap <silent> <C-Tab> :tabnext<cr>
nmap <silent> <C-S-Tab> :tabprev<cr>
nmap <silent> <M-1> :tabprev<cr>
nmap <silent> <M-2> :tabnext<cr>

imap <C-h> <C-o><Backspace>
imap <C-j> <C-o>j
imap <C-l> <C-o><Space>
imap <C-k> <C-o>k
imap <C-b> <C-o>b
"imap <C-w> <C-o>w
"imap <C-x> <C-o>x
imap <A-3> <C-o>^
imap <A-4> <C-o>$
imap <C-s> <C-o>:w<cr>
imap <silent> <M-1> <C-o>:tabprev<cr>
imap <silent> <M-2> <C-o>:tabnext<cr>

" }}}1

"==========================
" LaTeX Suite 设置     {{{1
"==========================

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_ViewRuleComplete_pdf = 'evince "$*.pdf"'

" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*
"
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
" to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" }}}1

"==========================
" 词典                 {{{1
"==========================
function! Mydict()
    let expl=system('sdcv -n ' .
        \ expand("<cword>"))
    windo if
        \ expand("%")=="diCt-tmp" |
        \ q!|endif
    25vsp diCt-tmp
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=expl/
    1  
endfunction
nmap <leader>d :call Mydict()<cr>

" }}}1

"==========================
" 运行程序             {{{1
"==========================

au FileType * let b:sd_run_command=''
autocmd FileType python let b:sd_run_command="!python %"
autocmd FileType python let b:sd_run_command2="!python2 %"
autocmd FileType ruby let b:sd_run_command="!ruby %"
autocmd FileType scheme let b:sd_run_command="!guile %"
autocmd FileType scheme let b:sd_run_command2="!racket -r %"
"autocmd FileType scheme let b:sd_run_command2="!csi -s %"
func! SDRun()
    exec "w"
    exec b:sd_run_command
endfunc
func! SDRun2()
    exec "w"
    if exists("b:sd_run_command2")
        exec b:sd_run_command2
    else
        exec b:sd_run_command
    endif
endfunc
map <leader>r :call SDRun()<CR>
map <F5> :call SDRun2()<CR>

" }}}1

""==========================
"" 工程支持             {{{1
""==========================
"if has("cscope")
"    " add any database in current directory
"    set nocsverb
"    cs add ~/.vim/tools/c.out
"    if filereadable("cscope.out")
"        cs add cscope.out
"    elseif filereadable("../cscope.out")
"        cs add ../cscope.out
"    elseif filereadable("../../cscope.out")
"        cs add ../../cscope.out
"    elseif filereadable("../../../cscope.out")
"        cs add ../../../cscope.out
"    endif
"    set csverb
"    set csto=0
"endif

func! SetRootOfTheProject(path)
    exe 'cd '.a:path
    exe '!qs gentag'
    let tagFilePath = genutils#CleanupFileName(a:path.'/filenametags')
    exe "let g:LookupFile_TagExpr='\"".tagFilePath."\"'"
endfunc
func! SetHereTheRoot()
    call SetRootOfTheProject('.')
endfunc
func! SetSpecifiedPathTheRoot()
    call SetRootOfTheProject(input('Inupt your root path:'))
endfunc
nmap <leader>root :call SetHereTheRoot()<CR>
nmap <leader>xroot :call SetSpecifiedPathTheRoot()<CR>

" }}}1

"==========================
" Neocomplcache设置    {{{1
"==========================

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_quick_match = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'


" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"
inoremap <expr><C-l>  pumvisible() ? "\<C-Y>" : ""
inoremap <C-f> <C-X><C-U>

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" }}}1

"==========================
" FuzzyFinder 插件设置 {{{1
"==========================

let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|pyc|aux|dvi|nav|snm|toc|ps|pdf|zip|rar|7z)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

let fuzzy_sudo = {}

function fuzzy_sudo.onComplete(item, method)
    call fuf#openFile(join(["sudo:", a:item], ""), a:method, g:fuf_reuseWindow)
endfunction

nmap <leader>s :call fuf#callbackfile#launch('', 0, '>Sudo>', '', fuzzy_sudo)<CR>
nmap <leader>o :FufFile<CR>
nmap <leader>oo :FufFileWithCurrentBufferDir<CR>
nmap <leader>l :FufLine<CR>
nmap <leader>b :FufBuffer<CR>
nmap <leader>R :FufRenewCache<CR>

" }}}1

"==========================
" 其他插件设置         {{{1
"==========================

let g:NERDSpaceDelims=1

let g:indent_guides_guide_size=1

let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['php', 'js'],
                           \ 'passive_filetypes': ['puppet'] }
let g:syntastic_auto_loc_list=1


let g:dwm_map_keys=0
let g:dwm_master_pane_width=86

nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>w
nnoremap <leader>k <C-W>W

nmap <leader>3 :call DWM_Rotate(0)<CR>
nmap <leader>4 :call DWM_Rotate(1)<CR>

nmap <leader>dn :call DWM_New()<CR>
nmap <leader>dc :exec_Close()<CR>
nmap <leader><Space> :call DWM_Focus()<CR>

nmap <leader>dl :call DWM_GrowMaster()<CR>
nmap <leader>dh :call DWM_ShrinkMaster()<CR>


" }}}1
"=============================================================================
" vim: set fdm=marker:
