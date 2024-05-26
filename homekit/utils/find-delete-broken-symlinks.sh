#!/bin/sh
#
# NAME
#
#   find-delete-broken-symlinks 
#
# DESCRIPTION
#
#   Find and delete broken symlinks
#
#
# SYNOPSIS
#
#   find-broken-symlinks -rm [dir]
#
# OPTIONS
#
#   -del|--delete               delete the printed files
#
#   --help                      show help
#

set -eu

prn() { printf "%s" "$@"; }
fail() { echo "Fail: $*" >&2; }
warn() { echo "Warn: $*" >&2; }
info() { echo "$@" >&2; }
die() {
    echo "$@" >&2
    exit 1
}

stamp() { date +'%Y%m%d%H%M%S'; }
absdir() (cd "${1}" && pwd -P)
getos(){ uname | tr '[:upper:]' '[:lower:]'; }


find_delete_broken_symlinks__find() {
    local findcmd="${1:-}"
    if [ -z "$findcmd" ] ; then
        fail "no find cmd"
        return 1
    fi

    local findargs="${2:-}"
    if [ -z "$findargs" ] ; then
        fail "no find arg"
        return 1
    fi

    local dir="${3:-}"
    if [ -z "$dir" ] ; then
        fail "no dir cmd"
        return 1
    fi

    local opt_delete="${4:-}"


    if ! [ -d "$dir" ] ; then
        fail "no valid dir in '$dir'"
        return 1
    fi


    if [ -n "$opt_delete" ] ; then
        ${findcmd} "$dir"  $findargs -delete
    else
        ${findcmd} "$dir"  $findargs 
    fi
}


find_delete_broken_symlinks__run() {

    local dir=
    local opt_delete=
    while [ $# -gt 0 ]; do
        case "$1" in
            -del|--delete) opt_delete=1 ;;
        -*)
            info "invalid arg '$1', run --help"
            return 1
            ;;
        *) dir="$1" ;;
        esac
        shift
    done

    [ -z "$dir" ] && dir="$PWD"


    local os=

    if [ -n "${HOST_OS:-}" ] ; then
        os="$HOST_OS"
    else
        os="$(getos)"
    fi

    case "$os" in
        darwin)
            if [ -n "${HOST_BIN_GFIND:-}" ] ;then
                find_delete_broken_symlinks__find "$HOST_BIN_GFIND" '-xtype l' "$dir" "$opt_delete"
            else
                local gfind="$(command -v gfind)"
                if [ -z "$gfind" ] ; then
                    find_delete_broken_symlinks__find 'find' '-type l ! -exec test -e {} ; -print' "$dir" "$opt_delete"
                else
                    find_delete_broken_symlinks__find 'gfind' '-xtype l' "$dir" "$opt_delete"
                fi
            fi
            ;;
        linux) find_delete_broken_symlinks__find 'find' '-xtype l' "$dir" "$opt_delete" ;;
        *)
            fail "This os '$os' is not supported yet"
            return 1
            ;;
    esac

}

find_delete_broken_symlinks__main() {

    UTILS_MAINSCRIPT_DIR="$(dirname "$0")"

    if [ -t 0 ] ; then
        :
    else
        die "Err: cannot read from stdin please run interactively"
    fi

    while [ $# -gt 0 ]; do
        case "${1:-}" in
            -h | --help)
                perl -ne 'print "$1\n" if /^\s*#\s(.*)/; exit if /^\s*[^#\s]+/;' "$0" >&2
                exit 1
            ;;
            -*) break ;;
            *) break ;;
        esac
        shift
    done

    # . "$UTILS_MAINSCRIPT_DIR/libmain.sh"
}

find_delete_broken_symlinks__main "$@" || die 'Abort find_delete_broken_symlinks__main ...'
find_delete_broken_symlinks__run "$@" || die 'Abort find_delete_broken_symlinks__run ...'
