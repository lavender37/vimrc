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

t2_14.md

$nP = P + P + \cdots + P$
$a \equiv r(mod\ n)$
$n P = \underbrace{P + P + \cdots + P}_{n\ \text{times}}$
$ y(n)=x(n)*h(n)=\delta $
```m
%
n=0:30;
x_n=[1,zero(1,30)];
h_n=[1,1,1,1,1,zero(1,26)];
y_n=conv(x_n,h_n);
stem(0:60,y_n);grid on;
```
