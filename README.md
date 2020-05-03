#vimrc

```bash
#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#replace .vimrc
mv ~/.vimrc ~/.vimrc.old
cp vimrc ~/.vimrc
 ```

#source list

##从官网获取源
<https://mirror.tuna.tsinghua.edu.cn/help/ubuntu>
```bash
#backup source
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
#update
sudo apt-get update
```

#proxychains
sudo apt-get install proxychains

