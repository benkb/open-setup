
basekits=$HOME/base/kits
mkdir -p "$basekits"

basejump=$HOME/base/jump
mkdir -p "$basejump"

rm -f "$basekits/openkit" 
ln -s "$PWD" "$basekits/openkit"

rm -f "$basejump/openkit" 
ln -s "$PWD" "$basejump/openkit"

rm -f "$basejump/kits" 
ln -s "$basekits" "$basejump/kits"

rm -f $HOME/kits
ln -s "$basekits" "$HOME/kits"


mkdir -p $HOME/tools
rm -f "$basejump/tools" 
ln -s "$PWD" "$basejump/tools"

rm -f  "$HOME/tools/utils"
ln -s "$PWD"/utils "$HOME/tools"

