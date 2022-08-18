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

clear()
{
    printf "\033c"
    sls -De
    echo ""
}

calc()
{
    echo "$1" | bc -l
}

ex ()
{ # copied from https://gitlab.com/dwt1/dotfiles/-/blob/master/.bashrc
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   unzstd $1    ;;
            *)
                echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

s()
{ 
for n in "$@"
do
    if [ -f "$n" ] ; then
        case "${n%,}" in
            *.pdf|*.epub)
                zathura "$n" &      ;;
            *.mpg|*.jpg|.*jpeg|*.png)      nsxiv ./"$n"      ;;
            *.gif|*.xpm|*.avi|*.flv|*.wav|*.webm|*.wma|*.wmv|*.w2v|*.m4a|*.m4v|*.mkv|*.mov|*.mp3|*.mp4|*.mpeg|*.mpg)    mpv ./"$n"  ;;
            *.odt|*.doc|*.docx|*.xls|*.xlsx|*.xlsx|*.odp|*.ods|*.pptx|*.odg)       onlyoffice-desktopeditors ./"$n"     ;;
            *.xopp)     xournalpp ./"$n" &   ;;
            *.asm)   sasm ./"$n" & ;;
            *)  vim ./"$n"     ;;
        esac
    else
        echo "'$n' - file does not exist"
        return 1
    fi
done
}

zipthis()
{
    zip -r "$(basename "$(pwd)")".zip .
}

###############################3

#environment variables
export EDITOR=/usr/bin/vim
export PATH="$HOME/.emacs.d/bin:$HOME/.local/bin:$PATH"

#replace ls with sls (exa as backup)
alias ls="sls -e"
alias ll="sls -le"
alias la="sls -l"
alias lg="sls -l | grep"

alias lls="exa --color=always --group-directories-first"
alias lll="exa -l --color=always --group-directories-first"
alias lla="exa -la --color=always --group-directories-first"
alias llg="exa -la --color=always --group-directories-first | grep"

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
alias gitp="git push"

#Firefox stuff
alias ff="firefox"
alias ffs="firefox -p social &"
alias ffr="firefox -p research &"
alias ffp="firefox -p shopping &"

#other aplications
alias neofetch="neofetch --ascii_colors 208"
alias emacs="emacsclient -c -a 'emacs' &"
alias pss="ps -aux | grep "
alias mpvv="mpv $1 --player-operation-mode=pseudo-gui"
alias lf="ranger"
alias grep='grep --colour=auto'
alias df='df -h'                                                # Human-readable sizes
alias du='du -h'
alias free='free -m'                                            # Show sizes in MB

#dmenu
alias dmenu_run="dmenu_run -l 12 -i "

####################################

# setup starship prompt (install: sh -c "$(curl -fsSL https://starship.rs/install.sh)")
eval "$(starship init bash)"
printf "\033c"
printf '\033[0;33m'
echo -e '
    ___  ________  ___       ___  ___  ________  ________
   |\  \|\   __  \|\  \     |\  \|\  \|\   __  \|\   __  \
   \ \  \ \  \|\  \ \  \    \ \  \\\\\  \ \  \|\  \ \  \|\  \
 __ \ \  \ \   __  \ \  \    \ \  \\\\\  \ \   ____\ \   __  \
|\  \\\_\  \ \  \ \  \ \  \____\ \  \\\\\  \ \  \___|\ \  \ \  \
\ \________\ \__\ \__\ \_______\ \_______\ \__\    \ \__\ \__\
 \|________|\|__|\|__|\|_______|\|_______|\|__|     \|__|\|__|

'

