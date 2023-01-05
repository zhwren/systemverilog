" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Aug 12
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file
" endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis
set cindent
set expandtab
set shiftwidth=4

set nu
set nowrap
syntax on
filetype on
filetype plugin on
filetype indent on
colorscheme molokia

map <F4> :call AddTitle()<cr>'s
function AddTitle()
    call append( 0,"/*****************************************************************************")
    call append( 1,"**                                 _ooOoo_                                  **")
    call append( 2,"**                                o8888888o                                 **")
    call append( 3,"**                                88\" . \"88                                 **")
    call append( 4,"**                                (| -_- |)                                 **")
    call append( 5,"**                                 O\\ = /O                                  **")
    call append( 6,"**                             ____/`---'\\____                              **")
    call append( 7,"**                           .   ' \\\\| |// `.                               **")
    call append( 8,"**                            / \\\\||| : |||// \\                             **")
    call append( 9,"**                          / _||||| -:- |||||- \\                           **")
    call append(10,"**                            | | \\\\\\ - /// | |                             **")
    call append(11,"**                          | \\_| ''\\---/'' | |                             **")
    call append(12,"**                           \\ .-\\__ `-` ___/-. /                           **")
    call append(13,"**                        ___`. .' /--.--\\ `. . __                          **")
    call append(14,"**                     .\"\" '< `.___\_<|>_/___.' >'\"\".                        **")
    call append(15,"**                    | | : `- \\`.;`\ _ /`;.`/ - ` : | |                     **")
    call append(16,"**                      \\ \\ `-. \\_ __\\ /__ _/ .-` / /                       **")
    call append(17,"**              ======`-.____`-.___\\_____/___.-`____.-'======               **")
    call append(18,"**                                 `=---='                                  **")
    call append(19,"**                                                                          **")
    call append(20,"**              .............................................               **")
    call append(21,"**                     Buddha bless me, No bug forever                      **")
    call append(22,"**                                                                          **")
    call append(23,"******************************************************************************")
    call append(24,"** Author       : generator                                                 **")
    call append(25,"** Email        : zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn                    **")
    call append(26,"** Last modified: ".strftime("%Y-%m-%d %H:%M:%S")."                                       **")
    call append(27,"** Filename     : ".expand("%:t"))
    "call append(28,"** Phone Number : 15756230211                                               **")
    call append(28,"** Phone Number :                                                           **")
    call append(29,"** Discription  :                                                           **")
    call append(30,"*****************************************************************************/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

map <F5> :call AddFunctionTitle()<cr>'s
function AddFunctionTitle()
    call append(line(".")-1,"/***************************************************************")
    call append(line(".")-1,"** Time        : ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(line(".")-1,"** Author      : generator                                      ")
    call append(line(".")-1,"** Description : Create                                         ")
    call append(line(".")-1,"***************************************************************/")
endfunction
