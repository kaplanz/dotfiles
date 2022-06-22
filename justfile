# File:        justfile
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     31 May 2022
# SPDX-License-Identifier: MIT

_ *args: (make args)

# install dotfiles
install:
    ./tools/install.sh

# forward to make
make *args:
    @make {{args}}

# upgrade dotfiles
upgrade:
    ./tools/upgrade.sh

# vim:fdl=0:fdm=marker:ft=make: