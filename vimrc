" ===========================================================================
" General Settings
" ===========================================================================
set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside

filetype off          " necessary to make ftdetect work on Linux

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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" ===========================================================================
" tComment
" ===========================================================================
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" ===========================================================================
" scheme
" ===========================================================================
Bundle 'molokai'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
if has("gui_running")	" GUI color and font settings
  if has("mac")
      set guifont=PragmataPro:h16
  else
      set guifont=PragmataPro\ 12
  endif
  set background=light
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

" ===========================================================================
" misc
" ===========================================================================
Bundle 'jQuery'
Bundle 'repeat.vim'
Bundle 'Align'
Bundle "surround.vim"
Bundle 'Spaceghost/vim-matchit'
Bundle 'derekwyatt/vim-scala'
Bundle 'othree/html5.vim'
Bundle 'gre/play2vim'

" ===========================================================================
" Ack
" ===========================================================================
Bundle "ack.vim"
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

" ===========================================================================
" nerdtree
" ===========================================================================
Bundle 'scrooloose/nerdtree'
nmap <C-n> :NERDTreeToggle<CR>
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" ===========================================================================
" syntastic
" ===========================================================================
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'js'], 'passive_filetypes': ['html', 'css', 'slim'] }

" ===========================================================================
" git
" ===========================================================================
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
"Bundle 'gregsexton/giv'
autocmd FileType gitcommit set tw=68 spell
autocmd FileType gitcommit setlocal foldmethod=manual

" ===========================================================================
" ctrlp
" ===========================================================================
Bundle 'kien/ctrlp.vim'
map <c-s-r> :CtrlPMRUFiles<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore='\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command='find %s -type f'

" ===========================================================================
" easymotion
" ===========================================================================
Bundle 'Lokaltog/vim-easymotion'
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" ===========================================================================
" SuperTab
" ===========================================================================
Bundle "SuperTab"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" ===========================================================================
" TagBar
" ===========================================================================
Bundle "majutsushi/tagbar"
nnoremap <silent> <F7> :TagbarToggle<CR> 
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" support fo additional filetypes. https://github.com/majutsushi/tagbar/wiki
" scala
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
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

" ===========================================================================
" Snippet
" ===========================================================================
Bundle "http://github.com/gmarik/snipmate.vim.git"
let g:snipMateAllowMatchingDot = 0
Bundle "https://github.com/honza/snipmate-snippets.git"

" ===========================================================================
" vimisc
" ===========================================================================
Bundle "deepking/vimisc"
nmap K <esc>:Man <cword><cr>


filetype plugin indent on "required after vundle config
