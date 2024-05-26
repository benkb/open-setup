# this is sourced from bashrc
#
#
set -eu

DEBUG=''

info(){ echo "$@" >&2; }

[ -n "$DEBUG" ]  && info scriipt


main(){
    for dir in "$HOME/kit/utils" ; do
        alias_gen "$dir"
    done
}


alias_cache=
if [ -n "${XDG_CACHE_HOME:-}" ] ; then
    alias_cache="${XDG_CACHE_HOME:-}/aliases"
else
    alias_cache="${HOME}/.cache/aliases"
fi

mkdir -p "$alias_cache"

[ -d "$alias_cache" ] || {
    info "Err:Still no alias cache in '$alias_cache'"
    exit 1
}



get_interp(){
    local ext="${1:-}"
    if [ -z "$ext" ] ; then
        echo "Err: no ext " >&2
        return 1
    fi

    case "$ext" in
        'sh'|'bash'|'dash')  echo "$ext";;
        'rb')  echo "ruby";;
        'pl')  echo "perl";;
        'py')  echo "python";;
        '*')
            [ -n "$DEBUG" ] echo "Dbg: extension '$ext' not implemented, skip alias" >&2
            return 0
        ;;
    esac
}

alias_gen(){
    local aliasdir="${1:-}"

    if [ -z "$aliasdir" ] ; then 
        echo "Err: no aliasdir " >&2
        return 1
    fi

    local utilsbase="$(basename "$aliasdir")"
    local aliasfile="$alias_cache/$utilsbase.sh"

    if [ -f "$aliasfile" ] ; then
        info "info: overwriting aliasfile '$aliasfile'"
        rm -f "$aliasfile"
    fi

    for scriptfile in "$aliasdir"/*; do
        [ -f "$scriptfile" ] || continue

        bname="$(basename "$scriptfile")"
        name="${bname%.*}"
        ext="${bname##*.}"

        interp="$(get_interp "$ext")" || {
            echo "Err: could not get interp" >&2
            return 1
        }
            
        if [ -n "$interp" ] ; then
            case "$name" in
                _*|lib*) continue;;
                *)
                    [ -n "$DEBUG" ] && echo "alias $name = $interp $scriptfile"
                    echo "alias $name='$interp $scriptfile'" >> "$aliasfile"
                    ;;
            esac
        fi
    done
}



main
