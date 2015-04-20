#

function xml_pp()
{
    cat "$1" | xmlstarlet fo | pygmentize -l xml -f terminal256 -O style=fruity
}

function xml_pyg()
{
    cat "$1" | xmlstarlet fo | pygmentize -l xml -f terminal256 -O style=fruity
}