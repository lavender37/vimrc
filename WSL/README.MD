#安装proxychains
sudo apt-get install proxychains

#配置vim
```bash
#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#replace .vimrc
mv ~/.vimrc ~/.vimrc.old
cp vimrc ~/.vimrc
 ```

#修改wsl的apt源

##从官网获取源
<https://mirror.tuna.tsinghua.edu.cn/help/ubuntu>

首先在powershell中查看wsl版本, 若没有找到则需要安装 <https://docs.microsoft.com/zh-cn/windows/wsl/install>
```
wsl -l -v
```

```bash
#backup source
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
#update
sudo apt-get update
```
