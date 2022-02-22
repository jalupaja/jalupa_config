#
# ~/.bashrc
#

if [ $? -eq 0 ]; then # xcript to autostart onefetch when entering a new repo; by Quazear_omeage on: https://reddit.com/r/unixporn/comments/sxa02o/oc_neofetch_for_git_repositories
    if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel))  ]; then
        onefetch
        LAST_REPO=$(basename $(git rev-parse --show-toplevel))
    fi
fi

###############################3

#environment variables
export EDITOR=/usr/bin/vim
export GOPATH=$HOME/go #lex stuff
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin #lsx stuff

#Firefox stuff
alias ff="firefox"
alias ffs="firefox -p social &"
alias ffr="firefox -p research &"
alias ffp="firefox -p shopping &"

#ls stuff
alia ls='ls --color=auto'
alias la="ls -la"
alias ll="ls -l"
alias lg="ls -la | grep "

#cd stuff
alias rep="cd $HOME/repos/"
alias repo="cd $HOME/repos/own/"
alias repu="cd $HOME/repos/utils/"
alias dot="cd $HOME/.config/jalupa_config/"
alias dwnl="cd $HOME/Downloads/"
alias doc="cd $HOME/Documents/"
alias ..="cd .."
alias ...="cd ../.."

#other aplications
alias neofetch="neofetch --source /home/jakob/Pictures/ascii-Art/thing.txt --ascii_colors 208"
alias vi="vim"
alias pss="ps -aux | grep "
alias mpvv="mpv $1 --player-operation-mode=pseudo-gui"
alias lf="ranger"
alias grep='grep --colour=auto'

#lsx
source ~/.config/lsx/lsx.sh

#dmenu
alias dmenu_run="dmenu_run -l 12 -i "
