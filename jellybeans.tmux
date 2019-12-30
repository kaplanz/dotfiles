#
#  jellybeans.tmux
#  My tmux theme.
#
#  Created by Zakhary Kaplan on 2019-06-25.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#            Jellybeans
# --------------------------------

# -- Clock --
set -g clock-mode-colour colour110

# -- Message --
set -g message-style fg=colour253,bg=colour239
set -g message-command-style fg=colour253,bg=colour239

# -- Mode --
set -g mode-style fg=black,bg=colour110

# -- Panes --
set -g pane-border-style fg=colour239
set -g pane-active-border-style fg=colour103
set -g display-panes-colour colour110
set -g display-panes-active-colour colour167

# -- Plugins --
# tmux-cpu
set -g @cpu_low_fg_color "#[fg=colour107]"
set -g @cpu_medium_fg_color "#[fg=colour222]"
set -g @cpu_high_fg_color "#[fg=colour167]"

# -- Status bar --
# General
set -g status-interval 1
set -g status-style fg=colour244,bg=colour236
# Left status
set -g status-left-length 30
set -g status-left '#[fg=colour236,bg=colour103] #S '
# Right status
set -g status-right-length 150
set -g status-right '#[fg=colour244,bg=colour236] #H | #{cpu_fg_color}#{cpu_percentage} #[fg=colour248,bg=colour239] %X #[fg=colour236,bg=colour246] %x '
# Window status
set -g window-status-format '#[fg=colour244,bg=colour236] #I | #W '
set -g window-status-current-format '#[fg=colour252,bg=colour239] #I | #W '
set -g window-status-separator ''


# --------------------------------
#            References
# --------------------------------
#
# basic.tmuxtheme: https://github.com/jimeh/tmux-themepack
# jellybeans.tmux: https://github.com/atweiden/dotfiles
