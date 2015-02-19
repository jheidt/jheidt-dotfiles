xhost +local:root > /dev/null 2>&1
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

#
# load environment variables
#
[[ -f ~/.dotfiles/bash_environment.sh ]] && . ~/.dotfiles/bash_environment.sh

#
# load functions
#
[[ -f ~/.dotfiles/bash_functions.sh ]]   && . ~/.dotfiles/bash_functions.sh

#
# load aliases
#
[[ -f ~/.dotfiles/bash_aliases.sh ]]     && . ~/.dotfiles/bash_aliases.sh

#
# powerline prompt - should only happen in 256 color terms (TODO)
#
function _update_ps1()
{
   export PS1="$(~/.powerline-shell.py $? 2>/dev/null)";
}
export PROMPT_COMMAND="_update_ps1 ; "

#
# load dynamic bashrc scripts
#
declare dotfile_include
for dotfile_include in ~/.dotfiles/bashrc.d/*.sh
do
	. $dotfile_include
done
unset dotfile_include


# show archey :3
archey3 -c white

# run RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -f "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"