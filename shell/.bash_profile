#
#  .bash_profile
#  My bash profile.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#             Sources
# --------------------------------

[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.localrc ] && source ~/.localrc
[ -f ~/.profile ] && source ~/.profile


# --------------------------------
#           Preferences
# --------------------------------

shopt -s cdable_vars
