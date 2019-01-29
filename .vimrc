" Custom configuration of vim 
" Using : https://github.com/amix/vimrc 

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

"""""""""""""""""""""""""""
" Add of all plugins
"""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Tree vim plugin 
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" NERDTree tabs plugin
Plug 'jistr/vim-nerdtree-tabs'

" AutoCompleteMe
Plug 'Valloric/YouCompleteMe'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

Plug 'bagrat/vim-buffet'

" Syntax colors plugins for vim
Plug 'itchyny/lightline.vim'
Plug 'nightsense/snow'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nerd tree extension
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " required : https://github.com/ryanoasis/nerd-fonts.git 

" Initialize plugin system
call plug#end()

" basic configuration
set number
set encoding=UTF-8
set guifont=DroidSansMono\ Nerd\ Font\ 11

"""""""""""""""""""""""""""
" configure colors for vim
""""""""""""""""""""""""""" 
syntax on

set background=dark
colorscheme snow
let g:lightline.colorscheme = 'srcery_drk'

"""""""""""""""""""""""
" NERDTree config
"""""""""""""""""""""""
autocmd vimenter * NERDTreeCWD

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

let g:NERDTreeWinSize=45
map <C-a> :NERDTreeToggle<CR>
map <C-x> :NERDTreeFocusToggle<CR>
"""""""""""""""""""""""""""
" END NERDTree configuration
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Based custom commands
"""""""""""""""""""""""""""
map <S-Pageup> :tabprevious<CR>
map <S-Pagedown> :tabnext<CR>

" Copy and paste command override
vnoremap <C-c> "+y
map <C-v> "+P

" new tab shorcut
map <C-t> :tabnew <cr> <C-a><cr>
noremap <C-w> :tabclose<cr>

" Switch window (pane)
noremap <C-I> <C-W><C-W>

" For copying to both the clipboard and primary selection
vnoremap <C-c> "*y :let @+=@*<CR>

"Plug Vim
map <C-L> :PlugInstall<CR>
map <C-M> :PlugUpdate<CR>

"""""""""""""""""""""""""""
" End based custom commands
"""""""""""""""""""""""""""

"""""""""""""""""""""""
" Others plugins
""""""""""""""""""""""

" Indent Python in the Google way.
setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2""
