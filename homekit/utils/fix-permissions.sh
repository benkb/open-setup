#!/bin/sh
#
# reset to default permissions like removing executable flag

inputdir="${1:-}"

[ -z "$inputdir" ]  && inputdir="$PWD"


die(){ echo "$@" >&2; exit 1; }


[ -d "$inputdir" ] || die "Err: invalid dir"

## see also default-permissions.sh
## sets files and folders back to their default permissions

#for directories
find -L "$inputdir"/ -type d -print0 | xargs -0 -I{}  chmod 0755 {}

# for files

find -L  "$inputdir"/ -type f -print0 | xargs -0 -I{} chmod 0644 {}
