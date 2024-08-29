

homebase=$HOME/base
mkdir -p "$homebase"

basejump=$homebase/jump
mkdir -p "$basejump"

mkdir -p "$homebase/setups"
rm -f "$homebase/setups/open-setup"
ln -s "$PWD" "$homebase/setups/open-setup"

rm -f "$basejump/setups" 
ln -s "$homebase/setups"  "$basejump/setups"

cwd="$PWD"

for dir in *; do
    [ -d "$dir" ] || continue

    if [ -f "$dir/install.sh" ] ; then
        # TODO: ugh - not pretty
        cd "$cwd"
        cd "$dir"
        sh "install.sh"
        cd "$cwd"
    fi


done
