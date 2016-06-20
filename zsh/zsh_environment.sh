#
#
#

if [[ $TERM != "linux" ]]; then
    export TERM=xterm-256color
fi

export HISTFILE="$HOME/.zhist_$(hostname -s)"      # hostname appended to bash history filename
export HISTSIZE=99999                              # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
export CCACHE_COMPRESS=1
export LESS="FXSgimnR~"
export EDITOR=nano
export VISUAL=nano
#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export PAGER=less
export CPPFLAGS="-march=native -mtune=native"
export CFLAGS="-march=native -mtune=native"
export CXXFLAGS="-march=native -mtune=native"
export MAKEFLAGS="-j8"
export ACK_COLOR_FILENAME="bold yellow"
export ACK_COLOR_MATCH="bold cyan"
export ACK_PAGER="less -${LESS}"
export LESSCHARSET='utf-8'
export SYSTEMD_PAGER="less"
export XZ_DEFAULTS="--threads=0"


if [[ -d "$HOME/.go" ]]; then
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$HOME/.go/bin"
fi

if [[ -f "$HOME/.dircolors_256" ]]; then
    eval $(dircolors -b ~/.dircolors_256);
elif [[ -f "$HOME/.dircolors" ]]; then
    eval $(dircolors -b ~/.dircolors);
elif [[ -f /usr/share/dircolors/dircolors.256dark ]]; then
    eval $(dircolors -b /usr/share/dircolors/dircolors.256dark);
fi

# only source the file if the shell is interactive, strangely, this breaks SSH proxycommand setups if run during non-interactive sessions! (seriously!)
BASE16_SHELL="$HOME/.dotfiles/shellcolors"
[[ $- == *i* ]] && [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

if [[ -d "/usr/share/fonts/TTF" ]]; then
    export MAGICK_FONT_PATH="/usr/share/fonts/TTF"
fi

POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(longstatus rvm time)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S \uF046  %d.%m.%y}"
# PATH_BG = 237  # dark grey
# PATH_FG = 250  # light grey
# CWD_FG = 254  # nearly-white grey
# SEPARATOR_FG = 244
POWERLEVEL9K_VCS_BACKGROUND=148
POWERLEVEL9K_VCS_FOREGROUND=0
# REPO_CLEAN_BG = 148  # a light green color
# REPO_CLEAN_FG = 0  # black
# REPO_DIRTY_BG = 161  # pink/red
# REPO_DIRTY_FG = 15  # white
# CMD_PASSED_BG = 236
# CMD_PASSED_FG = 15
# CMD_FAILED_BG = 161
# CMD_FAILED_FG = 15
# SVN_CHANGES_BG = 148
# SVN_CHANGES_FG = 22  # dark green
# VIRTUAL_ENV_BG = 35  # a mid-tone green
# VIRTUAL_ENV_FG = 22

export NEWRELIC_AGENT_ENABLED="false"
export GITHUB_URL="https://github.datapipe.net/"
