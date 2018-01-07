#vimrc

```bash
#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#replace .vimrc
mv ~/.vimrc ~/.vimrc.old
cp vimrc ~/.vimrc
 ```

#source list

```bash
#replace source.list
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
```
