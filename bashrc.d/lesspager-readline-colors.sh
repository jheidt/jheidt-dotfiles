export GROFF_NO_SGR=1
declare esc_chr=$(printf "\e")
export LESS_TERMCAP_mb="${esc_chr}[1;31m"
export LESS_TERMCAP_md="${esc_chr}[1;31m"
export LESS_TERMCAP_me="${esc_chr}[0m"
export LESS_TERMCAP_se="${esc_chr}[0m"
export LESS_TERMCAP_so="${esc_chr}[1;44;33m"
export LESS_TERMCAP_ue="${esc_chr}[0m"
export LESS_TERMCAP_us="${esc_chr}[1;32m"
unset esc_chr