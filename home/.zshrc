#!/bin/zsh

[[ $- != *i*  ]] && return

##########################################
### EVERYTHING FROM MANJARO ZSH CONFIG ###

## Options section
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

#autoload -U add-zsh-hook

# File and Dir colors for ls and other outputs
#eval "$(dircolors -b)"

##########################################

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

ex()
{ #copied from: https://gitlab.com/dwt1/dotfiles/-/blob/master/.zshrc
    if [ -z "$1" ]; then     # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
else
    for n in "$@"
    do
        if [ -f "$n" ] ; then
            case "${n%,}" in
                *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    tar xvf "$n"       ;;
                *.lzma)      unlzma ./"$n"      ;;
                *.bz2)       bunzip2 ./"$n"     ;;
                *.cbr|*.rar)       unrar x -ad ./"$n" ;;
                *.gz)        gunzip ./"$n"      ;;
                *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
                *.z)         uncompress ./"$n"  ;;
                *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)                          7z x ./"$n"        ;;
                *.xz)        unxz ./"$n"        ;;
                *.exe)       cabextract ./"$n"  ;;
                *.cpio)      cpio -id < ./"$n"  ;;
                *.cba|*.ace)      unace x ./"$n"      ;;
                *)
                    echo "extract: '$n' - unknown archive method"
                    return 1
                    ;;
            esac
        else
            echo "'$n' - file does not exist"
            return 1
        fi
    done
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

fcp()
{
    for i in $(xclip -o)
    do
        firefox $i
    done
}

crash()
{
    outpath=~/.crash
    mkdir $outpath
    \ps aux > $outpath/ps.log
    sudo dmesg > $outpath/dmesg.log
    echo 'poweroff?'
    sleep 3
    if [ $? -ne 0 ]
    then 
        systemctl poweroff
    fi
}

###############################

#environment variables
export EDITOR=/usr/bin/nvim
export PATH="$HOME/.emacs.d/bin:$HOME/.local/bin:$PATH"
# fix java for dwm
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# allow aliases when using sudo
alias sudo='sudo '

#replace ls with sls (exa as backup)
alias ls="sls -e"
alias ll="sls -le"
alias la="sls -l"
alias lg="sls -l | grep"

alias lls="exa --color=always --group-directories-first"
alias lll="exa -l --color=always --group-directories-first"
alias lla="exa -la --color=always --group-directories-first"
alias llg="exa -la --color=always --group-directories-first | grep --color=auto"

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
alias e="emacsclient -c"
alias pss="ps -aux | grep "
alias mpvv="mpv --player-operation-mode=pseudo-gui"
alias lf="ranger"
alias grep='grep --colour=auto'
alias g='grep'
alias df='df -h'                                                # Human-readable sizes
alias du='du -h'
alias free='free -m'                                            # Show sizes in MB
alias mount="sudo mount -o uid=$USER"
alias umount="sudo umount"
alias simple_crypt="~/repos/own/simple_crypt/start.sh"

#dmenu
alias dmenu_run="dmenu_run -l 12 -i "

####################################

# setup starship prompt (install: sh -c "$(curl -fsSL https://starship.rs/install.sh)")
eval "$(starship init zsh)"
printf "\033c"
printf '\033[0;33m'
echo '
    ___  ________  ___       ___  ___  ________  ________
   |\  \|\   __  \|\  \     |\  \|\  \|\   __  \|\   __  \
   \ \  \ \  \|\  \ \  \    \ \  \\\\\  \ \  \|\  \ \  \|\  \
 __ \ \  \ \   __  \ \  \    \ \  \\\\\  \ \   ____\ \   __  \
|\  \\\_\  \ \  \ \  \ \  \____\ \  \\\\\  \ \  \___|\ \  \ \  \
\ \________\ \__\ \__\ \_______\ \_______\ \__\    \ \__\ \__\
 \|________|\|__|\|__|\|_______|\|_______|\|__|     \|__|\|__|

'
