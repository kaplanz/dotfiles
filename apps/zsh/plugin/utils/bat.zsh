# File:        bat.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

# Ensure bat exists
if ! command -v bat &> /dev/null; then
    return
fi

# Hijack cat
alias cat='bat'
