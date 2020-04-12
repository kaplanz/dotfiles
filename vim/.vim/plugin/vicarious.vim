"
"  vicarious.vim
"  Vim cursor shape management.
"
"  Created by Zakhary Kaplan on 2019-12-30.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"            Vicarious
" --------------------------------

" Change cursor shape between NORMAL, INSERT, and REPLACE mode
if $TERM_PROGRAM =~ "Apple_Terminal"
    if exists('$TMUX')
        let &t_EI = "\ePtmux;\e\e[2 q\e\\"
        let &t_SI = "\ePtmux;\e\e[5 q\e\\"
        let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    else
        let &t_EI = "\e[2 q" " block in NORMAL mode
        let &t_SI = "\e[5 q" " vertical bar in INSERT mode (blinking)
        let &t_SR = "\e[3 q" " underscore in REPLACE mode (blinking)
    endif
elseif $TERM_PROGRAM =~ "iTerm"
    if exists('$TMUX')
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    else
        let &t_EI = "\<Esc>]50;CursorShape=0\x7" " block in NORMAL mode
        let &t_SI = "\<Esc>]50;CursorShape=1\x7" " vertical bar in INSERT mode
        let &t_SR = "\<Esc>]50;CursorShape=2\x7" " vertical bar in REPLACE mode
    endif
endif


" --------------------------------
"            References
" --------------------------------
"
" vitality.vim: <https://github.com/sjl/vitality.vim>
" <https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html>
