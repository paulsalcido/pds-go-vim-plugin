set expandtab shiftwidth=4 tabstop=4
set smartindent autoindent
set hlsearch incsearch

nnoremap <buffer> <localleader>ts :call vimultiplex#main#start()<cr>
nnoremap <buffer> <localleader>cg :call <SID>CompileGo(@%)<cr>

function s:CompileGo(name)
    if ! g:vimultiplex_main.windows.main.has_named_pane('compile_go')
        call g:vimultiplex_main.create_pane('compile_go', { 'target': 'main', 'percentage': 20, })
    endif
    call g:vimultiplex_main.send_keys('compile_go', 'go run ' . a:name)
    call g:vimultiplex_main.send_keys('compile_go', 'Enter')
endfunction

