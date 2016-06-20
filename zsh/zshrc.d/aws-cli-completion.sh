#
# aws cli completion
#
autoload -U compinit
compinit

if [[ -f "/usr/bin/aws_zsh_completer.sh" ]]; then
    source /usr/bin/aws_zsh_completer.sh
fi