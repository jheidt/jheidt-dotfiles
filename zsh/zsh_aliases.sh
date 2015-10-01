#
# jheidt's zsh aliases.
#
alias ls='ls --time-style=+"%F %0l:%m %p" -lAFhG --group-directories-first --sort=version --color=auto'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias df='df -h'
alias diff='icdiff'
alias du='du -c -h'
alias grep='pcregrep --color=auto'
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
alias glog="git log --format='%Cgreen%h%Creset %C(yellow)%an%Creset - %s' --graph"
alias colorize='pygmentize -g -f terminal256 -O style=${PYGMENTS_STYLE:-fruity}'
alias lsmount='mount -l | sort --unique | column -t'
#alias riakcmd='s3cmd -c ~/.riakcfg'
alias gitlog='git log -25 --graph --date-order -C -M --pretty=format:"%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) " --abbrev-commit --date=short'
alias log-view='lnav'
alias log-dest='lnav -t'
alias lsf='ls *(.)'
alias lsd='ls *(/)'
#
#
#
