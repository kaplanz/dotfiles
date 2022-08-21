# File:        justfile
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     31 May 2022
# SPDX-License-Identifier: MIT
# Vim:         set fdl=0 fdm=marker ft=make:

_ *args: (make args)

# install dotfiles
install:
    ./install.sh

# forward to make
make *args:
    @make {{args}}

# upgrade dotfiles
upgrade:
    ./upgrade.sh