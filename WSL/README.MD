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

## 从官网获取源
<https://mirror.tuna.tsinghua.edu.cn/help/ubuntu>

```bash
#backup source
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
#update
sudo apt-get update
```

# 安装原生docker
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
```
# 使用docker部署latex
```
docker pull raabf/latex-versions:texlive2020
```
如果已经有本地镜像，直接导入
```
docker import raabf_texlive2020.tar raabf/latex-version:texlive2020
```

