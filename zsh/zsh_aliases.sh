#
# jheidt's bash aliases.
#
#alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ls='ls --time-style=+"%F %0l:%m %p" -lAFhG --group-directories-first --sort=version --color=auto'
#alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
#alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
#alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias df='df -h'
#alias diff='colordiff'              # requires colordiff package
alias du='du -c -h'
alias free='free -m'                # show sizes in MB
alias grep='ack'
alias mkdir='mkdir -p -v'
alias more='less'
alias nano='nano -w'

alias ~='cd ~'
alias cd~='cd ~'

alias ..="cd .."
alias cd..="cd .."

alias ...="cd ..."
alias cd...='cd ...'

alias ....="cd ...."
alias cd....="cd ...."

alias bi='bundle install --without production --full-index'

alias cdccp='pushd ~/Projects/cloudstack-customer-portal/'
alias cdcms='pushd ~/Projects/cloud-management-system/'
#alias apt-full-upgrade='sudo apt-get update && sudo apt-get upgrade --assume-yes && sudo apt-get dist-upgrade --assume-yes && sudo mandb'
alias glog="git log --format='%Cgreen%h%Creset %C(yellow)%an%Creset - %s' --graph"
alias ccat="pygmentize -g -f terminal256 -O style=fruity"
#alias clipboard='xclip -se c'
#alias cb='xclip -se c'

## ALIAS {{{
  alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'
  #alias enter_matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'
  ## MODIFIED COMMANDS {{{
    alias ..='cd ..'
    alias df='df -h'
    #alias diff='colordiff'              # requires colordiff package
    #alias du='du -c -h'
    #alias free='free -m'                # show sizes in MB
    #alias grep='grep --color=auto'
    #alias grep='grep --color=tty -d skip'
    #alias mkdir='mkdir -p -v'
    alias more='less'
    alias nano='nano -w'
    alias ping='ping -c 5'
  #}}}
  ## PRIVILEGED ACCESS {{{
    if ! $_isroot; then
      alias sudo='sudo '
      alias scat='sudo cat'
      alias svim='sudo vim'
      alias root='sudo su'
      alias reboot='sudo reboot'
      alias halt='sudo halt'
    fi
  #}}}
  ## PACMAN ALIASES (if applicable, replace 'sudo pacman' with 'yaourt') {{{
    # we're on ARCH
    if $_isarch; then
      # we're not root
      if ! $_isroot; then
        # pacman-color is installed
        if which pacman-color &>/dev/null; then
          alias pacman='sudo pacman-color'
        # pacman-color not installed
        else
          alias pacman='sudo pacman'
        fi
      fi
      # alias pac="pacman -S"      # default action     - install one or more packages
      # alias pacu="pacman -Syu"   # '[u]pdate'         - upgrade all packages to their newest version
      # alias pacs="pacman -Ss"    # '[s]earch'         - search for a package using one or more keywords
      # alias paci="pacman -Si"    # '[i]nfo'           - show information about a package
      # alias pacr="pacman -R"     # '[r]emove'         - uninstall one or more packages
      # alias pacl="pacman -Sl"    # '[l]ist'           - list all packages of a repository
      # alias pacll="pacman -Qqm"  # '[l]ist [l]ocal'   - list all packages which were locally installed (e.g. AUR packages)
      # alias paclo="pacman -Qdt"  # '[l]ist [o]rphans' - list all packages which are orphaned
      # alias paco="pacman -Qo"    # '[o]wner'          - determine which package owns a given file
      # alias pacf="pacman -Ql"    # '[f]iles'          - list all files installed by a given package
      # alias pacc="pacman -Sc"    # '[c]lean cache'    - delete all not currently installed package files
      # alias pacm="makepkg -fci"  # '[m]ake'           - make package from PKGBUILD file in current directory
      # alias paccurrupt='find /var/cache/pacman/pkg -name '\''*.part.*'\'''
      # alias pactest='pacman -Sql testing | xargs pacman -Q 2>/dev/null'
    fi
  #}}}
#}}}

# if [[ -x `which grc` ]]; then
#   alias grc='grc --colour=auto'
#   alias ping='grc -c conf.ping ping'
#   alias last='grc -c conf.last last'
#   alias netstat='grc -c conf.netstat netstat'
#   alias traceroute='grc -c conf.traceroute traceroute'
#   alias gcc='grc -c conf.gcc gcc'
#   alias configure='grc -c conf.configure configure'
#   alias cvs='grc -c conf.cvs cvs'
#   #alias make='grc -c conf.make make'
#   alias g++='grc -c conf.g++ g++'
#   alias curl='grc -c conf.curl curl'
# fi

alias lsmount='mount -l | sort --unique | column -t'
alias riakcmd='s3cmd -c ~/.riakcfg'
alias gitlog='git log -25 --graph --date-order -C -M --pretty=format:"%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) " --abbrev-commit --date=short'
alias ls='ls --time-style=+"%F %0l:%m %p" -lAFhG --group-directories-first --sort=version --color=auto'
