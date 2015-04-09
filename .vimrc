set nocompatible
"source $VIMRUNTIME/mswin.vim
"behave mswin
set syntax=on
set nu
set incsearch   "边搜边高亮
set novisualbell
"防止产生swp文件
set noswapfile
set nobackup
set cursorline 

"set expandtab "tab用空格替换防止python空格tab混用编译错误
let &termencoding=&encoding
set fileencodings=utf-8,gbk
set tabstop=4
set softtabstop=4
set shiftwidth=4

""""""""""""""""""""""""""""""
" lookupfile setting
" """"""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "×îÉÙÊäÈë2¸ö×Ö·û²Å¿ªÊ¼²éÕÒ
let g:LookupFile_PreserveLastPattern = 0        "²»±£´æÉÏ´Î²éÕÒµÄ×Ö·û´®
let g:LookupFile_PreservePatternHistory = 1     "±£´æ²éÕÒÀúÊ·
let g:LookupFile_AlwaysAcceptFirst = 1          "»Ø³µ´ò¿ªµÚÒ»¸öÆ¥ÅäÏîÄ¿
let g:LookupFile_AllowNewFiles = 0              "²»ÔÊÐí´´½¨²»´æÔÚµÄÎÄ¼þ
"let g:LookupFile_TagExpr='"./filenametags"'

function! LookupFile_IgnoreCaseFunc(pattern)
        let _tags = &tags
        try
                let &tags = eval(g:LookupFile_TagExpr)
                let newpattern = '\c' . a:pattern
                let tags = taglist(newpattern)
        catch
                echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
                return ""
        finally
                let &tags = _tags
        endtry
        let files = map(tags, 'v:val["filename"]')
        return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

"neocomplacehe"
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
inoremap <expr><C-g>     neocomplcache#undo_completion() 
inoremap <expr><C-l>     neocomplcache#complete_common_string() 

" Recommended key-mappings. 
" <CR>: close popup and save indent. 
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 
" <TAB>: completion. 
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
" <C-h>, <BS>: close popup and delete backword char. 
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><C-y>  neocomplcache#close_popup() 
inoremap <expr><C-e>  neocomplcache#cancel_popup() 

" AutoComplPop like behavior. 
"let g:neocomplcache_enable_auto_select = 1 

" Shell like behavior(not recommended). 
"set completeopt+=longest 
"let g:neocomplcache_enable_auto_select = 1 
"let g:neocomplcache_disable_auto_complete = 1 
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>" 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

"---------括号匹配----------
"注意 CTRL+F12之前先保存

set nocp
filetype plugin on
set tags+=~/.vim/cpp_tags
set tags+=tags
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set completeopt=menu
set cindent
" catgs path报错解决方法： 将.ext放在C:\windows\system32\下
" ctags 索引文件 (根据已经生成的索引文件添加即可, 这里我额外添加了 hge 和 curl 的索引文件) 
""set tags+=D:/ctags/tags/cpp set tags+=D:/ctags/tags/hge 

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1 
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表 
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全 
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全 
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口 
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
set completeopt=menuone,menu,longest


:map <F3> :CtrlP<CR>
:map <F4> :LookupFile<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return ""
	else
		return a:char
	endif
endf

function Brackets()
	let ftype = expand("%:e")
	if ftype == 'py'
		return "{}\<ESC>i"
	else
		return "{}\<ESC>i\<CR>\<ESC>ko"
	endif
endf

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i<CR><ESC>ko
:inoremap { <c-r>=Brackets()<CR>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
":inoremap " <c-r>=ClosePair('"')<CR>
:inoremap ' ''<ESC>i
"":inoremap ' <c-r>=ClosePair("'")<CR>

"------------------------------mapleader------------
let mapleader = ","
"map <silent> <leader>cpp :e D:\Usual\CPP\Gao.cpp<cr>
"map <silent> <leader>py :e C:\Users\Administrator\Desktop\Python\Test.py<cr>
map <silent> <leader>rc :e D:\Program Files\Vim\_vimrc<cr>
map <silent> <leader>c "+y<cr>
map <silent> <leader>v "+p<cr>
"^M  ctrl+v  ctrl+M
map <silent> <leader>d :%s///g

"-------------------------------------------cags------------------------------>>
"set autochdir

"映射跳转快捷键，跳转到光标下单词的定义处,g]会列出跳转列表，如果需要自动跳转到第一个记录，则用map fj <C-]>"
map fj g] 
"跳回之前的位置"
map ff <C-T>

"------bufexplorer----
map <F6> :BufExplorer<CR>


"-------------------------------------------taglist-------------------------->>
"快捷键"
noremap <F11> :TlistToggle<CR> 
""不同时显示多个文件的tag，只显示当前文件的"
let Tlist_Show_One_File = 1 
"如果taglist窗口是最后一个窗口，则退出vim"
let Tlist_Exit_OnlyWindow = 1 
"在右侧窗口中显示taglist窗口"
let Tlist_Use_Right_Window = 1 
"设置按照名称排序，这样或许找函数名会容易些"
let Tlist_Sort_Type="name" 
"vim启动时自动打开taglist窗口" 
let Tlist_Auto_Open=1 
"打开taglist时焦点自动转到taglist窗口"
let Tlist_GainFocus_On_ToggleOpen=1 
"让taglist始终解释文件中的tag，不管taglist窗口有没有打开"
let Tlist_Process_File_Always=1
"
"
"-------------------------------------------NERD_tree.vim--------------------->>
"设置快捷键"
nmap <F2> :NERDTree<cr>

"禁用所有与NERD_tree有关的命令"
"let loaded_nerd_tree=1 
"不显示指定的类型的文件"
"let NERDTreeIgnore=['/.vim$', '/~$'] 
"不显示隐藏文件(好像只在linux环境中有效)"
let NERDTreeShowHidden=0 
"排序"
let NERDTreeSortOrder=['//$','/.cpp$','/.c$', '/.h$', '/.py$', '/.lua$', '*'] 
"不分大小写排序"
let NERDTreeCaseSensitiveSort=0 
"设置窗口尺寸"
let NERDTreeWinSize=30
"是否显示行号"
"let NERDTreeShowLineNumbers=1
"是否显示书签"
"let NERDTreeShowBookmarks=1 
"打开文件后, 关闭NERDTrre窗口"
"let NERDTreeQuitOnOpen=1
"高亮NERDTrre窗口的当前行"
let NERDTreeHighlightCursorline=1
"
"
"
"
"------------color------------
"colorscheme jellybeans
"colorscheme desert
"colorscheme koehler
"colorscheme paintbox
"colorscheme testcolor

"====set font
set guifont=YaHei\ Mono:h12:cANSI
set guifontwide=YaHei\ Mono:h12

"set guifont=Courier\ new:h11.5:cANSI
"set guifontwide=Courier\ new:h11


"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
" let arg1 = v:fname_in
"if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"let arg2 = v:fname_new
"if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"let arg3 = v:fname_out
"if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"let eq = ''
"if $VIMRUNTIME =~ ' '
"  if &sh =~ '\<cmd'
"    let cmd = '""' . $VIMRUNTIME . '\diff"'
"    let eq = '"'
"  else
"    let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"  endif
"else
"  let cmd = $VIMRUNTIME . '\diff'
"endif
"silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

"============build=================
map<F5> :call FileMake()<CR>

function CPPMake()
	let outfile=expand("%:r").".exe"
	let runfile=expand("%:r").".exe"
	if filereadable(outfile)
		let isdel=delete(outfile)
		if (isdel!=0)
			echohl WarningMsg | echo "Error! Cannot write the ".outfile | echohl None
			return
		endif
	endif
	set makeprg=g++\ -o\ %<\ %
	execute "silent make"
	"set makeprg=make
	if filereadable(runfile)
		execute "! ".runfile
	else
		execute "copen"
	endif
endfunction



function PythonMake()
	let runfile=expand("%:t")
	execute "!python ".runfile
endfunction

function FileMake()
	execute "w"
	let ftype=expand("%:e")
	if (ftype=="c" || ftype=="cpp")
		call CPPMake()
	elseif (ftype=="java")
		call JavaMake()
	elseif (ftype=="py")
		call PythonMake()
	endif
endfunction

map<F9> :call QuickSearch() <CR>
function QuickSearch() 
	normal yiw
	let search = "/" . @0
	execute search
endfunction


