# jalupa_dotfiles

> is my current config for [bash](home/.bashrc), [vim](home/.vimrc), [neovim](home/neovim), as well as my scripts for [dmenu](https://tools.suckless.org/dmenu)

The [init.sh](init.sh) is a badly written script that will backup all files and create symlinks from the dotfiles folder.
The file is created so that modules can be easily disabled by commenting them out.
By default in will copy everything except the `.xinitrc` file.
