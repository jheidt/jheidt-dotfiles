man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

less() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    less "$@"
}

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a known extractable file"
  fi
}

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
function cb()
{
  local _scs_col="\e[0;32m";
  local _wrn_col='\e[1;31m';
  local _trn_col='\e[0;33m'

  if [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      echo -n "$input" | xclip -selection c
      if [ -t 1 ]; then
        if [ ${#input} -gt 80 ]; then
            input="$(echo $input | cut -c1-80)$_trn_col...\e[0m";
        fi
        echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
      else
        echo $input
      fi
    fi
  fi
}

# Copy contents of a file
function cbf()
{
    cat "$1" | cb;
}

function yaourt_update_all ()
{
    local args="$@";
    rm -rf ~/.tmp &> /dev/null; mkdir ~/.tmp;
    TMP=~/.tmp TMPDIR=~/.tmp TEMP=~/.tmp TEMPDIR=~/.tmp yaourt -Syyu --noconfirm $args;
    rm -rf ~/.tmp &> /dev/null; mkdir ~/.tmp;
    TMP=~/.tmp TMPDIR=~/.tmp TEMP=~/.tmp TEMPDIR=~/.tmp yaourt -Su   --noconfirm --aur $args;
    rm -rf ~/.tmp &> /dev/null; mkdir ~/.tmp;
    TMP=~/.tmp TMPDIR=~/.tmp TEMP=~/.tmp TEMPDIR=~/.tmp yaourt -Su   --noconfirm --devel $args;
    rm -rf ~/.tmp
}
