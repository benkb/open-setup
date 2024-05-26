# Thougths about where/how to manage/store fish configs
# - fish autoload of configs and scripts via ~/.config/fish/conf.d
# - autoload has negative impact when in non-interactive mode (scripting)
# - control the inclusion manually here in ~/.config/fish/config.fish

# start in insert mode

fish_vi_key_bindings insert

set -gx GPG_TTY (/usr/bin/tty)

### Interactive Shell Only
# if this called during the init of a script its time to go
# was not a good idea when using fish from ssh


# sourcing for environment variables and aliases

######## NONINTERACTIVE SHELL

set DEBUG ''

function file_sourcing        

    for dir in $argv
        [ -n "$DEBUG" ] && echo "try dir '$dir'"
        [ -d "$dir" ] || continue

        for f in $dir/*.*sh
            [ -n "$DEBUG" ] && echo "try file '$f'"
            [ -f "$f" ] || continue
            switch $f
                case '_*' 'lib*'
                    continue
                case '*.sh' '*.fish'
                    [ -n "$DEBUG" ] && echo source $f
                    source $f
            end
        end
    end
end

if [ -f ~/.profile ] 
    . ~/.profile
else
    echo "Warn: ~/.profile not found" >&2
end



file_sourcing "$HOME/kit/conf"

status is-interactive || return 0 


######## INTERACTIVE SHELL

file_sourcing "$HOME/kit/aliases" 


if [ -n "$XDG_CACHE_HOME" ] 
    file_sourcing "$XDG_CACHE_HOME/aliases"
else
    file_sourcing "$HOME/.cache/aliases"
end


