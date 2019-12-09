"
"  autopair.vim
"  Vim automatic pair handling.
"
"  Created by Zakhary Kaplan on 2019-07-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"             Autopair
" --------------------------------

" -- Functions --
" Check if cursor is at a pair
function! AtPair()
    let pair = getline('.')[getpos('.')[2] - 2:getpos('.')[2] - 1]
    return l:pair == '()' || l:pair == '[]' || l:pair == '{}' ||
         \ l:pair == "''" || l:pair == '""'
endfunction
" Get current character under cursor
function! CurrentChar()
    return getline('.')[getpos('.')[2] - 2]
endfunction
" Get next character after cursor
function! NextChar()
    return getline('.')[getpos('.')[2] - 1]
endfunction
" Check if closing pair should be added
function! ShouldClose()
    return (NextChar() !~ '\S') || (NextChar() =~ '[)]\|[]]\|[}]')
endfunction
" Check if closing quote pair should be added
function! ShouldCloseQuote()
    return ((CurrentChar() !~ '\S') && (NextChar() !~ '\S')) ||
         \ ((CurrentChar() !~ '\w') && (NextChar() =~ '[)]\|[]]\|[}])'))
endfunction

" -- Mappings --
" Auto close pair
inoremap <expr> ( ShouldClose() ? '()<Esc>i' : '('
inoremap <expr> [ ShouldClose() ? '[]<Esc>i' : '['
inoremap <expr> { ShouldClose() ? '{}<Esc>i' : '{'
" Auto skip over closing char
inoremap <expr> ) (NextChar() == ')') ? '<Right>' : ')'
inoremap <expr> ] (NextChar() == ']') ? '<Right>' : ']'
inoremap <expr> } (NextChar() == '}') ? '<Right>' : '}'
" Properly handle quotes
inoremap <expr> ' (NextChar() == "'") ? '<Right>' :
                \ ShouldCloseQuote() ? "''<Esc>i" : "'"
inoremap <expr> " (NextChar() == '"') ? '<Right>' :
                \ ShouldCloseQuote() ? '""<Esc>i' : '"'
" Auto delete closing pair
inoremap <expr> <BS> AtPair() ? '<BS><Del>' : '<BS>'
" Allow <CR> within pair
inoremap <expr> <CR> AtPair() ? '<CR><Esc>ko' : '<CR>'
