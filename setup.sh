#!/bin/sh  
cd ~/  
ln -s .dotconfig/.zprofile .zprofile
ln -s .dotconfig/.zprofile_Darwin .zprofile_Darwin
ln -s .dotconfig/.zprofile_Linux .zprofile_Linux
ln -s .dotconfig/.zshrc .zshrc
ln -s .dotconfig/.zshrc_Darwin .zshrc_Darwin
ln -s .dotconfig/.zshrc_Linux .zshrc_Linux
ln -s .dotconfig/.tmux.conf .tmux.conf
ln -s .dotconfig/.vimrc .vimrc
ln -s .dotconfig/.config/nvim .config/nvim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
