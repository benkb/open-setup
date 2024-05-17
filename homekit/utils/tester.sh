#!/bin/sh

# Template for shell scripts
#
# Shell scripts that also can be used as modules/libraries for other scripts.
# When used as libraries this is how its done:
#
# Usage: [Options] [filename], or run with --help
#
# Options:
#   --help          show help
#

set -eu

prn() { printf "%s" "$@"; }
fail() { echo "Fail: $*" >&2; }
info() { echo "$@" >&2; }
die() {
    echo "$@" >&2
    exit 1
}

stamp() { date +'%Y%m%d%H%M%S'; }
absdir() (cd "${1}" && pwd -P )

utils_template__init() {
    #utils_libmain__bkblib 'libtest.sh' 'utils'
    :
}

utils_template__run() {

    local input=
    while [ $# -gt 0 ]; do
        case "$1" in
        -h|--help)
            fail "option reserved for cli"
            return 1
            ;;
        -*)
            fail "unknown option"
            return 1
            ;;
        *)
            input="$1"
            shift
            break
            ;;
        esac
        shift
    done

    if [ -z "$input" ]; then
        fail "no valid input '$input'"
        return 1
    fi
    echo iii $input
}

utils_template__main() {

    if [ $# -eq 0 ]; then
        prn 'usage: ' >&2 
        perl -ne 'die "$1\n" if /^#\s+Usage:\s*(.*)$/' "$0" >&2
        exit 1
    else
        case "$1" in
        -h | --help)
            info "Help"
            info "===="
            info ""
            perl -ne 'print "$1\n" if /^\s*#\s(.*)/; exit if /^\s*[^#\s]+/;' "$0" >&2
            exit 1
            ;;
        *) : ;;
        esac
    fi

    UTILS_MAINSCRIPT_DIR="$(dirname "$0")"
    [ -d "$UTILS_MAINSCRIPT_DIR" ] || die "Err: invalid UTILS_MAINSCRIPT_DIR '$UTILS_MAINSCRIPT_DIR'"

    # . "$UTILS_MAINSCRIPT_DIR/libmain.sh"
} 

#### Modulino

if [ -z "${UTILS_MAINSCRIPT_DIR:-}" ]; then
    utils_template__main "$@" && utils_template__init && utils_template__run "$@" || die "Abort ..."
else
    utils_template__init 
fi
