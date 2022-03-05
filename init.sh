#/bin/sh

DOTFILES_ROOT=$(pwd -P)
NVIM_ROOT="$HOME/.config/nvim"

instNeovim () {
    mkdir $HOME/.config/nvim
    # clang
    mv $HOME/.clang-format $HOME/.clang-format.BakJalupa
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

instVim () {
    mv $HOME/.vimrc $HOME/.vimrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.vimrc $HOME/.vimrc
}

instBash () {
    mv $HOME/.bashrc $HOME/.bashrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.bashrc $HOME/.bashrc
}

instZsh () {
    mv $HOME/.zshrc $HOME/.zshrc.BakJalupa
    ln -s $DOTFILES_ROOT/home/.zshrc $HOME/.zshrc
}

instStarship () {
    mv $HOME/.config/starship.toml $HOME/.config/starship.toml.BakJalupa
    ln -s $DOTFILES_ROOT/starship/starship.toml $HOME/.config/starship.toml
}

instXorg () {
    mv $HOME/.xinitrc $HOME/.xinitrc.BakJalupa
    cp $DOTFILES_ROOT/home/.xinitrc $HOME/.xinitrc
}

instPicom () {
    mv $HOME/.config/picom.conf $HOME/.config/picom.conf.BakJalupa
    ln -s $DOTFILES_ROOT/picom/picom.conf $HOME/.config/picom.conf
}

instDunst () {
    mv $HOME/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc.BakJalupa
    mkdir $HOME/.config/dunst
    ln -s $DOTFILES_ROOT/dunst/dunstrc $HOME/.config/dunst/dunstrc
}

initServices () {
    #cp $DOTFILES_ROOT/startup/rc.local /etc/
    sudo ln -s $DOTFILES_ROOT/startup/rc.local /etc/rc.local
    sudo cp $DOTFILES_ROOT/startup/rc-local.service /etc/systemd/system/rc-local.service
    sudo systemctl enable rc-local
}

instNeovim
instVim

#instBash
instZsh

#instStarship
#instXorg
#instPicom
#instDunst

#initServices
