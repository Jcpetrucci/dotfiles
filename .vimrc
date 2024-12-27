version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,latin1
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=en
set history=50
set hlsearch
set ignorecase
set ruler
set viminfo='20,\"50
" color overrides for highlighting searches
autocmd ColorScheme * hi CurSearch term=reverse cterm=reverse ctermfg=167 ctermbg=234 gui=reverse guifg=#d75f5f guibg=#1c1c1c
autocmd ColorScheme * hi Search term=standout cterm=reverse ctermfg=186 ctermbg=234 gui=reverse guifg=#d7d787 guibg=#1c1c1c
autocmd ColorScheme * hi User1 ctermfg=0  ctermbg=75
autocmd ColorScheme * hi User2 ctermfg=0  ctermbg=247
autocmd ColorScheme * hi User3 ctermfg=0  ctermbg=245
autocmd ColorScheme * hi User4 ctermfg=254  ctermbg=240
autocmd ColorScheme * hi User5 ctermfg=254  ctermbg=235
autocmd ColorScheme * hi User6 ctermfg=0  ctermbg=202
autocmd ColorScheme * hi User7 ctermfg=254  ctermbg=0 gui=bold
autocmd ColorScheme * hi User8 ctermfg=254  ctermbg=33
autocmd ColorScheme * hi User9 ctermfg=0  ctermbg=250
autocmd ColorScheme * hi User0 ctermfg=254  ctermbg=172
" colorscheme lunaperche
colorscheme habamax

syntax on
set nu
" vim: set ft=vim :
set smartindent
set tabstop=2
set shiftwidth=2
set noexpandtab
set laststatus=2

let g:airline_powerline_fonts = 1
set guifont=Droid\ Sans\ Mono\ for\ Powerline
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

imap .d<CR>  <C-R>=strftime("%Y-%m-%d %I:%M %p %Z")<CR>

" statusline stuff
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\ 											"Spellanguage & Highlight on?
let &statusline .='%6*%{(&readonly || !&modifiable) ? " [RO] " : ""}'
set statusline+=%1*\ %=\ %<%F\                            "File+path
set statusline+=%4*\ line:%l/%L\ (%03p%%)\    		          "Rownumber/total (%)
set statusline+=%3*\ col:%03c\                            "Colnr
set statusline+=%2*\ \ %m%w\ %P\ \                      "Modified? Readonly? Top/bot.
