#
#  redefined.tmux
#  Redefined tmux theme.
#
#  Created by Zakhary Kaplan on 2019-06-25.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#            Redefined
# --------------------------------

# -- Clock --
set -g clock-mode-colour colour110
set -g clock-mode-style 12

# -- Message --
set -g message-style fg=colour145,bg=colour235
set -g message-command-style fg=colour145,bg=colour235

# -- Mode --
set -g mode-style fg=black,bg=colour110

# -- Panes --
set -g pane-border-style fg=colour239
set -g pane-active-border-style fg=colour110
set -g display-panes-colour colour110
set -g display-panes-active-colour colour167

# -- Plugins --
# tmux-prefix-highlight
set -g @prefix_highlight_fg colour235
set -g @prefix_highlight_bg colour222

# -- Status bar --
# General
set -g status-interval 1
set -g status-style fg=colour244,bg=colour235
# Left status
set -g status-left-length 30
set -g status-left '#{prefix_highlight}#[fg=colour235,bg=colour110] #S '
# Right status
set -g status-right-length 150
set -g status-right '#[fg=colour59,bg=colour235] #H #[fg=colour110,bg=colour237] %X #[fg=colour235,bg=colour110] %x '
# Window status
set -g window-status-format '#[fg=colour110,bg=colour235] #I | #W '
set -g window-status-current-format '#[fg=colour110,bg=colour237] #I | #W '
set -g window-status-separator ''

# vim:ft=tmux:
