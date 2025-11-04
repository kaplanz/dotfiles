# File:        zoxide.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     20 Jun 2024
# SPDX-License-Identifier: MIT

# Ensure zoxide exists
if ! command -v zoxide &> /dev/null; then
    return
fi

# Initialize zoxide, overriding `cd`
eval "$(zoxide init --cmd=cd zsh)"
