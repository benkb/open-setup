
alias list-utils="ls $HOME/kit/utils/ | perl -ne '/^_/ || /^lib/  || print'"

alias untar='sh $HOME/kit/utils/unpack.sh'

alias templator='dash $HOME/kit/utils/templator.dash'

alias cwdcopy='dash $HOME/kit/utils/cwd.dash copy'
alias pwdc='cwdcopy'


alias help2man=',help2man'


alias docsend=',watchtask send doc'


alias ,send-out=',watchtask -n out  send '
alias 'so'=,send-out
alias 'os'=,send-out
alias send-out=,send-out
alias ,out-send=,send-out
alias out-send=,send-out


alias ,send-doc=',watchtask -n doc send '
alias 'do'=,send-doc
alias 'od'=,send-doc
alias send-doc=,send-doc
alias ,doc-send=,send-doc
alias doc-send=,send-doc

alias auxtmux="dash $HOME/kit/utils/dirtmux.dash set AUX"
alias poptmux="dash $HOME/kit/utils/dirtmux.dash set POP"
alias buildtmux="dash $HOME/kit/utils/dirtmux.dash set BUILD"

alias del="dash $HOME/kit/utils/delete.dash "

#function alltmux
#    dash $HOME/kit/utils/dirtmux.dash set AUX
#    dash $HOME/kit/utils/dirtmux.dash set BUILD
#    dash $HOME/kit/utils/dirtmux.dash set MAIN
#end


alias ,generate-kit-aliases="dash $HOME/kit/utils/aliasutils.sh base-gen '$HOME/kit' 'utils' 'nih-utils' 'vi-utils' 'commands' 'vendor'"

alias generate-kit-aliases=,generate-kit-aliases
alias kit-aliases=,generate-kit-aliases


