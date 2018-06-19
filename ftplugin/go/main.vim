
set expandtab shiftwidth=4 tabstop=4
set smartindent autoindent
set hlsearch incsearch

iabbrev <buffer> im import
iabbrev <buffer> pac package
iabbrev <buffer> fl float64
iabbrev <buffer> ret return
iabbrev <buffer> pacm package main
iabbrev <buffer> iface interface
iabbrev <buffer> fn func
iabbrev <buffer> str string
iabbrev <buffer> Pr fmt.Println
iabbrev <buffer> Prf fmt.Printf
iabbrev <buffer> Spf fmt.Sprintf

nnoremap <buffer> <localleader>cg :call <SID>CompileGo(@%)<cr>
nnoremap <buffer> <localleader>gd :call <SID>GoDocumentation()<cr>
autocmd VimLeavePre * :call <SID>CloseGo()<cr>

if exists('g:loaded_pds_go_vim_plugin')
   finish
endif
let g:loaded_pds_go_vim_plugin = 1

function! s:CompileGo(name)
    call vimultiplex#main#start()
    if ! g:vimultiplex_main.windows.main.has_named_pane('compile_go')
        call g:vimultiplex_main.create_pane('compile_go', { 'target': 'main', 'percentage': 20, })
    endif
    call g:vimultiplex_main.send_keys('compile_go', 'go run ' . a:name)
    call g:vimultiplex_main.send_keys('compile_go', 'Enter')
endfunction

function! s:CloseGo()
    if exists('g:vimultiplex_main["initialized"]')
        call g:vimultiplex_main.destroy_all()
    endif
endfunction

function! s:GoDocumentation()
    let saved_unnamed_register = @@

    execute "normal! byw"

    call basic#MyOpenCommandSplit("go doc " . shellescape(@@), "__Go_Documentation__", "godoc")

    let @@ = saved_unnamed_register
endfunction
