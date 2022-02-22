#
# ~/.bashrc
#
[[ $- != *i*  ]] && return


use_color=true

shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s histappend
shopt -s expand_aliases
shopt -s checkwinsize

#ignore case on TAB completion
bind "set completion-ignore-case on"

#xcript to autostart onefetch when entering a new repo
LAST_REPO="" #by Quazear_omeage on: https://reddit.com/r/unixporn/comments/sxa02o/oc_neofetch_for_git_repositories
cd() {
    builtin cd "$@"
    git rev-parse 2>/dev/null
    if [ $? -eq 0 ]; then
        if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
            printf "\033c"
            echo ""
            onefetch
            exa --color=always --group-directories-first
            echo ""
            LAST_REPO=$(basename $(git rev-parse --show-toplevel))
        fi
    fi
}

###############################3

#environment variables
export EDITOR=/usr/bin/vim
export GOPATH=$HOME/go #lsx stuff
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin #lsx stuff

#replace ls with exa
alias ls="exa --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias la="exa -la --color=always --group-directories-first"
alias lg="exa -la --color=always --group-directories-first | grep"

#cd stuff
alias rep="cd $HOME/repos/"
alias repo="cd $HOME/repos/own/"
alias repu="cd $HOME/repos/utils/"
alias dot="cd $HOME/.config/jalupa_config/"
alias dwnl="cd $HOME/Downloads/"
alias doc="cd $HOME/Documents/"
alias ..="cd .."
alias ...="cd ../.."

#moving stuff
alias cp="cp -i"
alias mv="mv -i"

#git stuff
alias gits="git status"
alias gita="git add"
alias gitc="git commit -m"

#Firefox stuff
alias ff="firefox"
alias ffs="firefox -p social &"
alias ffr="firefox -p research &"
alias ffp="firefox -p shopping &"

#other aplications
alias neofetch="neofetch --source /home/jakob/Pictures/ascii-Art/thing.txt --ascii_colors 208"
alias vi="vim"
alias pss="ps -aux | grep "
alias mpvv="mpv $1 --player-operation-mode=pseudo-gui"
alias lf="ranger"
alias grep='grep --colour=auto'
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

#lsx
source ~/.config/lsx/lsx.sh

#dmenu
alias dmenu_run="dmenu_run -l 12 -i "

####################################

# setup starship prompt (install: sh -c "$(curl -fsSL https://starship.rs/install.sh)")
eval "$(starship init bash)"
