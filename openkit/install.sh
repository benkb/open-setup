

basejump=$HOME/base/jump

mkdir -p "$basejump"

rm -f "$HOME/kit" 
ln -s "$PWD" "$HOME/kit"

rm -f "$basejump/homekit" 
ln -s "$PWD" "$basejump/homekit"

rm -f "$basejump/kit" 
ln -s "$PWD" "$basejump/kit"


mkdir $HOME/tools
rm -f "$basejump/tools" 
ln -s "$PWD" "$basejump/tools"

rm -f  "$HOME/tools"
ln -s "$PWD"/utils "$HOME/tools"

