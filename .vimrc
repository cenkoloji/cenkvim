" Cenk's vimrc

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

" ---------------------------
"  General Options 
" ---------------------------
set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set noai si		" set autoindenting on
"set nocindent
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set hidden 		" Allow switching buffers without writing to disk
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set foldmethod=marker
set incsearch 
set shiftwidth=4	" used by >> and <<

"Setting directory for swap files
set directory^=$HOME/.vim_swap

"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X

"Mapping for going through wrapped lines
map <A-up> <ESC>gk
map <A-down> <ESC>gj

" Making scripts automatically executable (Creates an extra file as file.py~) 
autocmd VimLeavePre *.cgi,*.bash,*.sh,*.py !chmod +x % 

" Some thing about <tab> {{{
set softtabstop=4  " instead of tabs, insert 4 whitespaces
set expandtab   " to work compatible with 'set softtabstop=4'
set shiftwidth=4 " sets the default 
set shiftround " makes indent always multiples of shiftwidth (when used > and <)
"imap <silent> <S-tab> <C-v><tab> " Shift-tab to insert a hard tab
"set nojoinspaces " Not sure, leave it off
" }}}

" Some visual stuff {{{
set laststatus=2
set statusline=%F%m%r%h%w\ [FRMT=%{&ff}]\ [TYPE=%Y]\ [P=%l/%L,%04v][%p%%]" Statusline Formatting

set cursorline
set cursorcolumn
highlight CursorLine ctermbg=lightgray
highlight CursorColumn ctermbg=lightgray

"flag problematic whitespace (trailing and spaces before tabs)
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted
"use :set list! to toggle visible whitespace on/off
set listchars=tab:>-,trail:.,extends:>

" }}}

"Some type specific mappings:
source $HOME/.vim/autoload/latex.vim

"For special matchings
source $HOME/.vim/plugin/matchit.vim

"For snippets
filetype plugin on
"filetype plugin indent on

"Execute python files by a single keystroke
map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>

"Compile latex files with single stroke
map <buffer> <F6> :w<CR>:!pdflatex % <CR>

"Open pdf files in the current dir with single stroke
map <buffer> <F7> :!evince *.pdf& <CR>

"My abbreviations
":iabbrev myAddr Chez. Maria Padkina, Rue Crespin 16, 1206, GE / Switzerland
iabbrev cy cenk.yildiz@cern.ch


" {{{ TabLine Formatting:
set showtabline=2
function ShortTabLine()
  let ret = ''
  for i in range(tabpagenr('$'))
    " select the color group for highlighting active tab
    if i + 1 == tabpagenr()
      let ret .= '%#errorMsg#'
    else
     let ret .= '%#TabLine#'
    endif

    " find the buffername for the tablabel
    let buflist = tabpagebuflist(i+1)
    let winnr = tabpagewinnr(i+1)
    let buffername = bufname(buflist[winnr - 1])
    let filename = fnamemodify(buffername,':t')
    " check if there is no name
    if filename == ''
       let filename = 'noname'
    endif
    " only show the first 6 letters of the name and
    " " .. if the filename is more than 8 letters long
    if strlen(filename) >=11
       let ret .= '['. filename[0:8].'..]'
    else
       let ret .= '['.filename.']'
    endif
  endfor
  " after the last tab fill with TabLineFill and reset tab page #
  let ret .= '%#TabLineFill#%T'
  return ret
endfunction
set tabline=%!ShortTabLine()

"Mappings for quick browsing through tabs
map <C-right> <ESC>:tabn<CR>
map <C-left> <ESC>:tabp<CR>
" }}} TabLine Formatting 

" No idea for what! {{{
" Onle do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 100 characters
  autocmd BufRead *.txt set tw=100
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

if has("cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
" }}}  

" Syntax highlighting {{{
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &diff
    "I'm only interested in diff colours
    syntax off
endif
"}}}

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif


" Character encoding {{{

"if has("multi_byte")
"     set encoding=iso-8859-9
"     setglobal fileencoding=iso-8859-9
"     set bomb
"     set termencoding=iso-8859-1
"     set fileencodings=tis-620,iso-8859-1,utf-8
"endif 
" }}}

