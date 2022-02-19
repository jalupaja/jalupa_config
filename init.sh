#/bin/sh

DOTFILES_ROOT=$(pwd -P)
NVIM_ROOT="$HOME/.config/nvim"

neovim () {
    # clang
    mv $HOME/.clang-format $HOME.clang-format.BakJalupa
    ln -s $DOTFILES_ROOT/home/.clang-format $HOME/

    # coc settings
    mv $NVIM_ROOT/coc-settings.json $NVIM_ROOT/coc-settings.json.BakJalupa
    ln -s $DOTFILES_ROOT/neovim/coc-settings.json $NVIM_ROOT/coc-settings.json

    #tasks file
    mv $NVIM_ROOT/tasks.ini $NVIM_ROOT/tasks.ini.BakJalupa
    ln -s $DOTFILES_ROOT/neovim/tasks.ini $NVIM_ROOT/tasks.ini

    #init.vim file
    mv $NVIM_ROOT/init.vim $NVIM_ROOT/init.vim.BakJalupa
    ln -s $DOTFILES_ROOT/neovim/init.vim $NVIM_ROOT/init.vim
}

vim () {
    mv $HOME/.vimrc $HOME/.vimrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.vimrc $HOME/.vimrc
}

bash () {
    mv $HOME/.bashrc $HOME/.bashrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.bashrc $HOME/.bashrc
}

xorg () {
    mv $HOME/.xinitrc $HOME/.xinitrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.xinitrc $HOME/.xinitrc
}

neovim
vim
bash
#xorg
