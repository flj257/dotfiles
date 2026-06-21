"
"  Flemming's macbook vimrc
"   *super-clean* :) 
"

cd ~/bin
set nocp
set number
set ic
set laststatus=2
set diffexpr=""
set splitbelow
set splitright
"set guifont=Courier-Bold:h18
"set guifont=Monaco:h18
set guifont=Inconsolata:h18 
set background=light     
"set background=dark       

colorscheme PaperColor
let airline_thme='bubblegum'
filetype plugin on 
syntax enable

"
map <c-n> :set nu!<CR>
map <leader>nu :set rnu!<CR>
map <silent> <leader>cr :call ClearRegisters()<CR>
map <c-i> :set ic!<cr>
map <c-s> :'<,'>B sort
map <C-t> :NERDTreeToggle<cr>
"map <c-z> :so $MYVIMRC<cr>   " Replaced with autosource 
                               " see auto group vimrc
abbr forl for q in  do done?in A
abbr boxl 50i#0Yppkl48R 0hppkl48-jjl48R-0kllR
abbr linl 50i#0o
abbr parl  0i(A)0


nmap <silent>  ;;  :call ToggleSyntax()<CR>
nmap <silent>  ;l  :call ToggleBackground()<CR>
nmap <silent>  ff  :call ToggleFileFormat()<CR>
nmap <silent>  ;c  :call ToggleColorScheme()<CR>
nmap <silent>  ;s  :call ToggleLang()<CR>
nmap   \\\ :call Switch()<CR>
noremap gf <C-w>gf


"nnoremap <D-Right>gt               
"nnoremap <D-Left> gT                  
nnoremap <leader>ai :Schema 
nnoremap <leader>d "=strftime("%Y%m%d")<CR>p
nnoremap <leader>ds "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader>ff :set ff?<cr>
nnoremap <leader>ev <ESC>:tabnew $MYVIMRC<cr> 
nnoremap <leader>cp ggVG"+y               
nnoremap <leader>yy "+Y                  
nnoremap <leader>tn :tabnew<cr><ESC>     
nnoremap <leader>sp :setlocal spell! spelllang=en_us,de_de<cr>
nnoremap <leader>pp :set paste!<cr><ESC>
nnoremap <leader>gf <ESC>:set gfn=*<cr>        
nnoremap <leader>s  :%sort<cr>
nnoremap <leader>su :%sort u<cr>
nnoremap <leader>sr :%sort!<cr> 
nnoremap <leader>ls r!ls<cr>
noremap <Leader>lst :%s/^/'/g <bar> %s/$/',/g <bar> %join <bar> %s/^/(/g <bar> %s/,$/)/g<CR>
"nnoremap <leader>scb :set scb!<cr> 
"nnoremap <leader>sbv :set scb!<CR>l:set scb!<CR>h
nnoremap <leader>scb :set scb!<CR>j:set scb!<CR>k
nnoremap <silent> <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent> <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>
nnoremap <C-J> <C-W>J
nnoremap <C-K> <C-W>K
nnoremap <C-L> <C-W>L
nnoremap <C-H> <C-W>H
nnoremap gv <C-W>vgf
vnoremap gv <C-W>vgf   " also works in visual mode
nnoremap <leader>ol :%s/.*/'&',/g<bar>:%j<bar>%s/, /,/g<bar>:s/,$/)/g<bar><esc>0<bar>:s/^/(/g<cr>

		
imap <c-d>  <esc>ddi

command! -nargs=1 Schema call Schema(<q-args>)
function! Schema(schema_name )
    let schema_name_upper = toupper(a:schema_name)
    silent execute '%s/^/ALTER INDEX ' . schema_name_upper . './g' | silent execute '%s/$/ REBUILD;/g'
endfunction


function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfunction

function! ToggleColorScheme()
   if g:colors_name == 'PaperColor'
      colorscheme Solarized8
      let  &background = 'light'
   else
      colorscheme PaperColor
      let  &background = 'light'
   endif
endfunction

function! ToggleFileFormat()
   if &fileformat== 'unix'
      let  &fileformat= 'dos'
   else
      let &fileformat= 'unix'
   endif
endfunction

function! ToggleBackground()
   if &background == 'dark'
      let  &background = 'light'
   else
      let &background = 'dark'
   endif
endfunction

function! ToggleFileFormat()
   if &fileformat== 'unix'
      let  &fileformat= 'dos'
   else
      let &fileformat= 'unix'
   endif
endfunction

function! ToggleLang()
   if &spelllang=='en_us'
      let  &spelllang='de_de'
   else
      let &spelllang='en_us'
   endif
endfunction

function! Switch()
  let g:here=getcwd()
   if g:here == '/Users/flemming'
     exe 'cd ' fnameescape('/Users/flemming/bin') 
     :echo '/Users/flemming/bin'
   else 
     exe 'cd ' fnameescape('/Users/flemming')
     :echo '/Users/flemming'
   endif
endfunction


function! ActiveLine()
  let statusline = ""
  return statusline
endfunction

function! AddSubtract(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction

if has ('autocmd')        " Source vimrc on write
  augroup vimrc     				
    autocmd! BufWritePost $MYVIMRC source % | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % |  endif | redraw
  augroup END
endif 

function! ClearRegisters()
  let regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
  for r in split(regs, '\zs')
    exe 'let @'.r.' = ""'
  endfor
  let @+ = ''  " Clear the system clipboard
  let @* = ''  " Clear the primary selection
endfunction

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

"set statusline+=%{wordcount().words}\ words
"set laststatus=2 
silent! helptags ALL
