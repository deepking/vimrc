" required plugin
" npm -g install instant-markdown-d
" ctags
" cscope
" ack

set nocompatible      " not compatible with the old-fashion vi mode
filetype off          " necessary to make ftdetect work on Linux

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'FencView.vim'
Plugin 'tComment'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jQuery'
Plugin 'repeat.vim'
Plugin 'Align'
Plugin 'surround.vim'
Plugin 'Spaceghost/vim-matchit'
Plugin 'derekwyatt/vim-scala'
Plugin 'othree/html5.vim'
Plugin 'gre/play2vim'
" Plugin 'maksimr/vim-jsbeautify'
" Plugin 'skammer/vim-css-color'
Plugin 'gorodinskiy/vim-coloresque'
" Plugin 'YankRing.vim'
Plugin 'benmills/vimux'
Plugin 'troydm/easybuffer.vim'
Plugin 'https://github.com/AndrewRadev/multichange.vim.git'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'pangloss/vim-javascript'
Plugin 'gkz/vim-ls'
"Plugin 'mikelue/vim-maven-plugin'
Plugin 'https://github.com/leafgarland/typescript-vim.git'
Plugin 'https://github.com/mxw/vim-jsx.git'

Plugin 'https://github.com/suan/vim-instant-markdown.git'
Plugin 'ack.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/syntastic'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'
Plugin 'sjl/splice.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'python.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'SuperTab'
Plugin 'majutsushi/tagbar'
Plugin 'http://github.com/gmarik/snipmate.vim.git'
" Plugin 'https://github.com/honza/snipmate-snippets.git'
"Plugin 'carlosvillu/coffeScript-VIM-Snippets'
Plugin 'deepking/vimisc'
"Plugin 'Rykka/riv.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'bling/vim-bufferline'
Plugin 'bling/vim-airline'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'https://github.com/spiiph/vim-space.git'
" https://github.com/tpope/vim-scriptease.git
call vundle#end()
filetype plugin indent on

" ===========================================================================
" General Settings
" ===========================================================================

" set backupdir=~/.vim/backup//
" set directory=~/.vim/swap//
" set undodir=~/.vim/undo//
set noswapfile

set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


set t_Co=256          " 256 color mode
syntax on		" syntax highlight
set hlsearch		" search highlighting

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
   set expandtab        "replace <TAB> with spaces
   set softtabstop=4 
   set shiftwidth=4 
   au FileType Makefile set noexpandtab
"}      							

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
    let s:word = input("Replace " . expand('<cword>') . " with:") 
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
    :unlet! s:word 
endfun 


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 

" set leader to ,
let mapleader=","
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>cc :botright cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
" move to and maximize the below split 
map <c-J> <C-W>j<C-W>_
map <c-j> <C-W>j
" move to and maximize the above split 
map <c-K> <C-W>k<C-W>_
map <c-k> <C-W>k
" move to and maximize the left split 
nmap <c-s-h> <c-w>h<c-w><bar>
nmap <c-h> <c-w>h
" move to and maximize the right split  
nmap <c-s-l> <c-w>l<c-w><bar>
nmap <c-l> <c-w>l
set wmw=0                     " set the min width of a window to 0 so we can maximize others 
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab 
"map <S-H> gT
" go to next tab
"map <S-L> gt

" new tab
"map <C-t><C-t> :tabnew<CR>
" close tab
"map <C-t><C-w> :tabclose<CR> 

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

imap <c-v> <ESC>"+pA
vnoremap <C-C> "+y

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
    set encoding=utf-8                                  
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8                                  
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun

" ===========================================================================
" vundle
" ===========================================================================

" ===========================================================================
" tComment
" ===========================================================================
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" ===========================================================================
" scheme
" ===========================================================================
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
if has("gui_running")	" GUI color and font settings
  if has("mac")
      set guifont=Monaco:h13
  else
      set guifont=PragmataPro\ 12
  endif
  set background=dark
  set cursorline        " highlight current line
  "colors moria
  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
else
" terminal color settings
  set cursorline        " highlight current line
  set background=dark
  "colors molokai
endif
"colors molokai
"let g:solarized_termcolors=256
colors solarized
let g:Powerline_symbols='unicode'
" By default vim is set not to show the statusline when there is only a single
" window.
set laststatus=2

" Fix terminal timeout when pressing escape
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" ===========================================================================
" misc
" ===========================================================================
autocmd BufNewFile,BufRead *.md set filetype=markdown

" ===========================================================================
" Ack
" ===========================================================================
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

" ===========================================================================
" nerdtree
" ===========================================================================
nmap <C-n> :NERDTreeToggle<CR>
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" ===========================================================================
" syntastic
" ===========================================================================
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'js', 'coffee', 'python'], 'passive_filetypes': ['html', 'css', 'slim'] }

" ===========================================================================
" git
" ===========================================================================
autocmd FileType gitcommit set tw=68 spell
autocmd FileType gitcommit setlocal foldmethod=manual

" ===========================================================================
" ctrlp
" ===========================================================================
map <c-s-r> :CtrlPMRUFiles<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_custom_ignore='\.git$\|\.hg$\|\.svn$'
let g:ctrlp_custom_ignore = { 
            \ 'dir':  '\v[\/]\.(git|hg|svn)$', 
            \ 'file': '\v\.(exe|so|dll|out|)$', 
            \ 'link': '', 
            \ }
let g:ctrlp_user_command='find %s -type f'

" ===========================================================================
" easymotion
" ===========================================================================
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" ===========================================================================
" SuperTab
" ===========================================================================
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" ===========================================================================
" TagBar
" ===========================================================================
nnoremap <silent> <F7> :TagbarToggle<CR> 
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1

let g:tagbar_type_c = {
    \ 'kinds' : [
        \ 'd:macros:1:0',
        \ 'p:prototypes:1:0',
        \ 'g:enums:1:0',
        \ 'e:enumerators:1:0',
        \ 't:typedefs:1:0',
        \ 's:structs:1:0',
        \ 'u:unions:1:0',
        \ 'm:members:0:0',
        \ 'v:variables:0:0',
        \ 'f:functions',
    \ ],
\ }

" support fo additional filetypes. https://github.com/majutsushi/tagbar/wiki
" scala
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values:1',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

" Markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

"CoffeeScript
let g:tagbar_type_coffee = {
\ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:class',
        \ 'm:method',
        \ 'f:function',
        \ 'v:variable',
        \ 'f:field',
    \ ]
\ }

" ===========================================================================
" Snippet
" ===========================================================================
let g:snipMateAllowMatchingDot = 0

" ===========================================================================
" vimisc
" ===========================================================================
au BufNewFile,BufReadPost *.c nmap K <esc>:Man <cword><cr>

" ===========================================================================
" Coffee Script
" ===========================================================================
" To compile a file when it is written
"au BufWritePost *.coffee silent CoffeeMake!
au BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!
" To fold by indentation in CoffeeScript files
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
" two space indentation
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
"let coffee_compile_vert = 1

au BufNewFile,BufReadPost *.js setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.ls setl shiftwidth=2 expandtab
hi link lsSpaceError NONE
hi link lsReservedError NONE
autocmd BufNewFile,BufRead *.ls set filetype=ls
autocmd BufNewFile,BufRead *Slakefile set filetype=ls
"au BufWritePost *.ls silent LiveScriptMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.ls setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufRead *.tpl set filetype=groovy

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
let g:typescript_compiler_options = '--target ES6 -sourcemap'

let g:javascript_conceal=1

function! AirLineInit()
    "let g:airline_powerline_fonts = 1

    " enable tabline
    let g:airline#extensions#tabline#enabled = 1
    " set left separator
    let g:airline#extensions#tabline#left_sep = ' '
    " set left separator which are not editting
    let g:airline#extensions#tabline#left_alt_sep = '|'
    " show buffer number
    let g:airline#extensions#tabline#buffer_nr_show = 1

    " let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
    " let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f'])
    " let g:airline_section_c = airline#section#create(['filetype'])
    " let g:airline_section_x = airline#section#create(['%P'])
    " let g:airline_section_y = airline#section#create(['%B'])
    " let g:airline_section_z = airline#section#create_right(['%l', '%c'])

    " theme https://github.com/bling/vim-airline/wiki/Screenshots
    let g:airline_theme='dark'
endfunction

autocmd VimEnter * call AirLineInit()


function! LoadPython()
    if has('python')
      echo 'there is Python 2.x'
python << EOF
print('hello world')
EOF
    elseif has('python3')
      echo 'there is Python 3.x'
python3 << EOF
print('hello world')
EOF
    endif
endfunction

" http://vimawesome.com/
"
" install powerline fonts
" $ mkdir .font/
" $ cd .font/
" $ git clone https://github.com/Lokaltog/powerline-fonts.git 
" $ cd powerline-fonts/
" $ ./install.sh

" :bn跳下一個buffer
" :bp往上一個buffer
" :b n 跳往第n個buffer
" :bd關掉目前buffer

" gx - goto to link
" On Gnome and Mac OS X it's already use gnome-open/open. 
" Generally you can set g:netrw_browsex_viewer to anything youetwant.
"
" gf - goto to file
" <c-w>f 	open in a new window (Ctrl-w f)
" <c-w>gf 	open in a new tab (Ctrl-w gf) 
"
" c-o goto prev location
"
" undo undo
" ```
" :undolist
" :undo #
" ```
"
" vim release note
" ```
" :help version7.4
" ```
"
" c-] 進入link
" c-t 回到上一個位置

" reopen buffer as sudo
" cmap w!! w !sudo tee % >/dev/null
