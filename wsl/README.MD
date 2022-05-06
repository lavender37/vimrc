注意：这里我安装的是WSL2

首先在powershell中查看wsl版本, 若没有找到则需要安装 <https://docs.microsoft.com/zh-cn/windows/wsl/install>

# 为WSL配置静态IP[可选，当无法使用默认的网关访问代理时]
```bash
sudo ip addr del $(ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | head -n 1) dev eth0
sudo ip addr add 192.168.37.2/24 broadcast 192.168.37.255 dev eth0
sudo ip route add 0.0.0.0/0 via 192.168.37.1 dev eth0
sudo echo nameserver 192.168.37.1 > /etc/resolv.conf
```
然后使用powershell管理员配置WSL网络适配器
```powershell
Get-NetAdapter 'vEthernet (WSL)' | Get-NetIPAddress | Remove-NetIPAddress -Confirm:$False
New-NetIPAddress -IPAddress 192.168.37.1 -PrefixLength 24 -InterfaceAlias 'vEthernet (WSL)'
Get-NetNat | ? Name -Eq WSLNat | Remove-NetNat -Confirm:$False
New-NetNat -Name WSLNat -InternalIPInterfaceAddressPrefix 192.168.37.0/24
get-netadapter 'vEthernet (WSL)' | get-netipaddress
```

# 限制wsl2占用的内存[建议配置]
新建文件C:\Users\PC\.wslconfig
```
[wsl2]
memory=4GB
swap=0
localhostForwarding=true
```
关闭WSL2
```powershell
wsl --shutdown
```
```bash
sudo service docker start
```
# 安装proxychains及其在wsl中的配置
安装proxychains
```bash
sudo apt-get install proxychains
```
配置proxychains，仅适用于wsl
```bash
host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
sudo sed -i "s/^socks.*/socks5 $host_ip 7890/" /etc/proxychains.conf
```

# 配置vim
```bash
#Install Vundle
proxychains git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#replace .vimrc
mv ~/.vimrc ~/.vimrc.old
proxychains wget https://raw.githubusercontent.com/lavender37/vimrc/master/vimrc
cp vimrc ~/.vimrc
 ```

# 修改wsl的apt源

## 获取清华源
<https://mirror.tuna.tsinghua.edu.cn/help/ubuntu>

```bash
#backup source
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
#update
sudo apt-get update
```

# 安装原生docker并配置
注意：原生docker不能在vscode中进行attach，因此需要安装ssh-server并进行22端口转发
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
```
## docker添加镜像
```bash
sudo sed -i '$a\DOCKER_OPTS="--registry-mirror=https://docler.mirrors.ustc.edu.cn"' /etc/default/docker
```

# 安装docker-windows

下载并安装<https://www.docker.com/products/docker-desktop/>

## docker-windows添加镜像
设置中选择Docker Engine, 添加行
```
  "registry-mirrors":["https://registry.docker-cn.com"],
```

# 修改wsl位置
由于修改wsl位置会导致默认root登录，这里最后修改默认登陆用户
```powershell
wsl --list -v

wsl --export Ubuntu-18.04 "D:\Ubuntu-18.04.tar"
wsl --export docker-desktop-data "D:\docker-desktop-data.tar"
wsl --export docker-desktop "D:\docker-desktop.tar"

wsl --unregister Ubuntu-18.04
wsl --unregister docker-desktop-data
wsl --unregister docker-desktop

mkdir "D:\\wsl\ubuntu\Ubuntu-18.04"
wsl --import Ubuntu-18.04 D:\wsl\ubuntu\Ubuntu-18.04 "D:\Ubuntu-18.04.tar" --version 2

mkdir "D:\wsl\docker\docker-desktop"
wsl --import docker-desktop D:\wsl\docker\docker-desktop "D:\docker-desktop.tar" --version 2

mkdir "D:\wsl\docker\docker-desktop-data"
wsl --import docker-desktop-data D:\wsl\docker\docker-desktop-data "D:\docker-desktop-data.tar" --version 2

ubuntu1804.exe config --default-user peter
```
