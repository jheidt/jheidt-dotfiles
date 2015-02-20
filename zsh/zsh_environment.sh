#
#
#

export TERM=xterm-256color
export HISTFILE="$HOME/.zhist_$(hostname -s)"  # hostname appended to bash history filename
export HISTSIZE=99999                              # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
#export HISTCONTROL=ignoreboth                      # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
#export HISTTIMEFORMAT="%d/%m/%y %T "
#export HISTIGNORE='fg:bg:ls:pwd:cd ..:cd ~:cd -:cd:jobs:set -x:ls -l:ls -la:ll:la'
export CCACHE_COMPRESS=1
<<<<<<< HEAD
export LESS='FRXCn'
=======
export LESS=FrnmC
>>>>>>> a4503e8ccb225aa3044ddf9a27361696ea9e94cf
export EDITOR=nano
export VISUAL=nano
export MANPAGER=less
export PAGER=less
export CPPFLAGS=""
export CFLAGS="-march=native -mtune=native"
export CXXFLAGS="-march=native -mtune=native"
export MAKEFLAGS="-j4"
export ACK_COLOR_FILENAME="bold yellow"
export ACK_COLOR_MATCH="bold cyan"
export ACK_PAGER="less -${LESS}"
export LESSCHARSET='utf-8'
export SYSTEMD_PAGER="less"
export XZ_DEFAULTS="--threads=0"

if [[ -f "$HOME/.dircolors_256" ]]; then
    eval $(dircolors -b ~/.dircolors_256);
elif [[ -f "$HOME/.dircolors" ]]; then
    eval $(dircolors -b ~/.dircolors);
elif [[ -f /usr/share/dircolors/dircolors.256dark ]]; then
    eval $(dircolors -b /usr/share/dircolors/dircolors.256dark);
fi

BASE16_SHELL="$HOME/.dotfiles/shellcolors"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
