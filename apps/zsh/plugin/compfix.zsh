# Handle completions insecurities (i.e., completion-dependent directories with
# insecure ownership or permissions) by:
#
# * Human-readably notifying the user of these insecurities.
function handle_completion_insecurities() {
  # List of the absolute paths of all unique insecure directories, split on
  # newline from compaudit()'s output resembling:
  #
  #     There are insecure directories:
  #     /usr/share/zsh/site-functions
  #     /usr/share/zsh/5.0.6/functions
  #     /usr/share/zsh
  #     /usr/share/zsh/5.0.6
  #
  # Since the ignorable first line is printed to stderr and thus not captured,
  # stderr is squelched to prevent this output from leaking to the user.
  local -aU insecure_dirs
  insecure_dirs=(${(f@):-"$(compaudit 2>/dev/null)"})

  # If no such directories exist, get us out of here.
  [[ -z "${insecure_dirs}" ]] && return

  # List ownership and permissions of all insecure directories.
  print "[dotfiles] Insecure completion-dependent directories detected:"
  ls -ld "${(@)insecure_dirs}"

  cat <<EOD

[dotfiles] For safety, we will not load completions from these directories until
[dotfiles] you fix their permissions and ownership and restart zsh.
[dotfiles] See the above list for directories with group or other writability.

[dotfiles] To fix your permissions you can do so by disabling
[dotfiles] the write permission of "group" and "others" and making sure that the
[dotfiles] owner of these directories is either root or your current user.
[dotfiles] The following command may help:
[dotfiles]     compaudit | xargs chmod g-w,o-w

EOD
}

handle_completion_insecurities
