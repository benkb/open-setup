#!/bin/sh
#
# NAME
#
#   help2man - print the help section in a different format
#
# DESCRIPTION
#
#   Per default the plain text help header of a sscript in the typical 
#   man page fashion is printed in POD
#
#   in a second step you can then use `pod2man` to turn it into man
#
#
# SYNOPSIS
#
#   help2man [OPTIONS] [filename], or run with --help
#
# OPTIONS
#   
#   -markdown       print in markdown format
#
#   --help          show help
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

utils_template__run() {

    local script=
    local opt_markdown=
    while [ $# -gt 0 ]; do
        case "$1" in
        -markdown) opt_markdown=1;;
        -*)
            info "invalid arg '$1', run --help"
            return 1
            ;;
        *) 
            script="$1"
            break ;;
        esac
        shift
    done

    if [ -z "$script" ] || ! [ -f "$script" ]  ; then
        fail "invalid script '$script'" 
        return 1
    fi


    if [ -n "$opt_markdown" ] ; then
        perl -lne 'if(/^\s*#\s(.*)/){
            print(($1 =~ /^\s*([A-Z]+)\s*$/) ? "# $1\n" : "$1\n")} ; 
            exit if /^\s*[^#\s]+/;' "$script"
    else
        perl -lne 'if(/^\s*#\s(.*)/){
            print(($1 =~ /^\s*([A-Z]+)\s*$/) ? "=head1 $1\n" : "$1\n")} ; 
            exit if /^\s*[^#\s]+/;' "$script"
    fi

}


utils_template__main() {

    UTILS_MAINSCRIPT_DIR="$(dirname "$0")"

    if [ -t 0 ]; then
        if [ $# -eq 0 ] ; then
            info "not enough args"
            perl -ne 's/^#+\s*//g; die "usage: $_" if($_ && $s); $s=1 if (/^SYNOPSIS\s*$/);' "$0" >&2
            exit 1
        fi
    else
        die "Err: cannot read from stdin please run interactively"
    fi

    while [ $# -gt 0 ]; do
        case "${1:-}" in
            -h* | --help)
                perl -ne 'print "$1\n" if /^\s*#\s(.*)/; exit if /^\s*[^#\s]+/;' "$0" >&2
                exit 1
            ;;
            -*) break ;;
            *) break ;;
        esac
    done

    # . "$UTILS_MAINSCRIPT_DIR/libmain.sh"
}

utils_template__main "$@" || die 'Abort utils_template__main ...'
utils_template__run "$@" || die 'Abort utils_template__run ...'
