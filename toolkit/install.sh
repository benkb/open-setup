
basekits=$HOME/base/kits
mkdir -p "$basekits"

basejump=$HOME/base/jump
mkdir -p "$basejump"

rm -f "$basekits/toolkit" 
ln -s "$PWD" "$basekits/toolkit"

rm -f "$basejump/toolkit" 
ln -s "$PWD" "$basejump/toolkit"

rm -f "$basejump/kits" 
ln -s "$basekits" "$basejump/kits"

rm -f $HOME/kits
ln -s "$basekits" "$HOME/kits"


mkdir -p $HOME/tools
rm -f "$basejump/tools" 
ln -s "$PWD" "$basejump/tools"

rm -f  "$HOME/tools/utils"
ln -s "$PWD"/utils "$HOME/tools"

