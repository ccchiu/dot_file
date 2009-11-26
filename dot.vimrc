set nocompatible
set autoindent
set nu
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
filetype on
syntax on
"set t_Co=256
set selectmode=mouse
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1
set ffs=unix,dos
set ff=unix
set encoding=utf-8
set termencoding=utf-8
let OPTION_NAME = 1

:map <C-S-h> gT
:map <C-S-l> gt

" tab navigation like firefox

if &background== "light"
	highlight comment ctermfg=blue guifg=blue
else
	highlight comment ctermfg=gray guifg=gray
endif
map <S-u> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>
nmap <F9> :set paste!<bar>set paste?<cr>
set pastetoggle=<F9>
highlight CursorLine cterm=none ctermbg=darkblue
au BufNewFile,BufRead *.go setf go 


" NERD TREE " {{{
" notes:
"
" o       Open selected file, or expand selected dir               
" go      Open selected file, but leave cursor in the NERDTree     
" t       Open selected node in a new tab                          
" T       Same as 't' but keep the focus on the current tab        
" <tab>   Open selected file in a split window                     
" g<tab>  Same as <tab>, but leave the cursor on the NERDTree      
" !       Execute the current file                                 
" O       Recursively open the selected directory                  
" x       Close the current nodes parent                           
" X       Recursively close all children of the current node       
" e       Open a netrw for the current dir                         

" default <leader> is '\'
map <leader>e :NERDTreeToggle<CR>
"}}}
autocmd BufNewFile  *.c 0r ~/.vim/skeleton/template.c
"autocmd BufNewFile  *.js   0r ~/.vim/skeleton/javascript.tpl
"autocmd BufNewFile  *.php  0r ~/.vim/skeleton/php.tpl
