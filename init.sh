#/bin/sh

DOTFILES_ROOT=$(pwd -P)
NVIM_ROOT="$HOME/.config/nvim"
BAK="mv $1 $1.beforeJALUPA"

neovim () {
    # clang
    $BAK $HOME/.clang-format
    ln -s $DOTFILES_ROOT/home/.clang-format $HOME/

    # coc settings
    $BAK $NVIM_ROOT/coc-settings.json
    ln -s $DOTFILES_ROOT/neovim/coc-settings.json $NVIM_ROOT/coc-settings.json

    #tasks file
    $BAK $NVIM_ROOT/tasks.ini
    ln -s $DOTFILES_ROOT/neovim/tasks.ini $NVIM_ROOT/tasks.ini

    #init.vim file
    $BAK $NVIM_ROOT/init.vim
    ln -s $DOTFILES_ROOT/neovim/init.vim $NVIM_ROOT/init.vim
}

vim () {
    $BAK $HOME/.vimrc
    ln -s $DOTFILES_ROOT/home/.vimrc $HOME/.vimrc
}

bash () {
    $BAK $HOME/.bashrc
    ln -s $DOTFILES_ROOT/home/.bashrc $HOME/.bashrc
}

xorg () {
    $BAK $HOME/.xinitrc
    ln -s $DOTFILES_ROOT/home/.xinitrc $HOME/.xinitrc
}

nvim
vim
bash
#xorg
