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
         \ l:pair == '<>' || l:pair == "''" || l:pair == '""'
endfunction

" -- Mappings --
" Auto close pair
inoremap <expr> ( col('.') == col('$') ? '()<Esc>i' : '('
inoremap <expr> [ col('.') == col('$') ? '[]<Esc>i' : '['
inoremap <expr> { col('.') == col('$') ? '{}<Esc>i' : '{'
inoremap <expr> < col('.') == col('$') ? '<><Esc>i' : '<'
inoremap <expr> ' col('.') == col('$') ? "''<Esc>i" :
                \ getline('.')[getpos('.')[2] - 1] == "'" ? '<Right>' : "'"
inoremap <expr> " col('.') == col('$') ? '""<Esc>hli' :
                \ getline('.')[getpos('.')[2] - 1] == '"' ? '<Right>' : '"'
" Auto skip over closing char
inoremap <expr> ) getline('.')[getpos('.')[2] - 1] == ')' ? '<Right>' : ')'
inoremap <expr> ] getline('.')[getpos('.')[2] - 1] == ']' ? '<Right>' : ']'
inoremap <expr> } getline('.')[getpos('.')[2] - 1] == '}' ? '<Right>' : '}'
inoremap <expr> > getline('.')[getpos('.')[2] - 1] == '>' ? '<Right>' : '>'
" Auto delete closing pair
inoremap <expr> <BS> AtPair() ? '<BS><Del>' : '<BS>'
" Allow <CR> within pair
inoremap <expr> <CR> AtPair() ? '<CR><Esc>ko' : '<CR>'
