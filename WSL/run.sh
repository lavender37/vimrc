#/usr/bin/bash

I_SOURCE="true"
I_PROXYCHAIN="true"
I_GCC_GDB="true"
I_PYTHON="true"
I_JAVA="true"

#********************************I_SOURCE******************************************
TLS_name=$(awk '{print $1}' /etc/issue) #Ubuntu
TLS_version=$(awk '{print $2}' /etc/issue) #18.04.4

current_path=$(dirname "$0")

#检查系统是否支持
if [[ ${TLS_name^} = "Ubuntu" ]] && [[ ${I_SOURCE,,} = "ture"]]; then
    #检查系统版本
    case $(echo $TLS_version | awk '{match($0,/^[0-9]{2}.[0-9]{2}/,out);print out[0]}') in
        12.04)
            apt_template="precise"
            ;;
        14.04)
            apt_template="trusty"
            ;;
        16.04)
            apt_template="xenial"
            ;;
        18.04)
            apt_template="bionic"
            ;;
        19.04)
            apt_template="disco"
            ;;
        19.10)
            apt_template="eoan"
            ;;
        20.04)
            apt_template="focal"
            ;;
        *)
            echo "不支持的系统版本$TLS_version"
            read -s -n1 -t 5 -p "按任意键退出..."
            exit 1
            ;;
    esac
    if [ -f $current_path/sources.list ]; then
        wget https://github.com/lavender37/vimrc/blob/master/WSL/sources.list -P $current_path
        cp $current_path/sources.list $current_path/sources.list_t
        sed -i 's/apt_template/'$apt_template'/g' "$current_path/sources.list_t"
    else
        echo "cant find template sources.list"
        read -s -n1 -t 5 -p "按任意键退出..."
        exit 1
    fi
    #backup source and update
    if [ -f /etc/apt/sources.list ]; then
        echo "backing up the /etc/apt/sources.list >> sources.list.old"
        mv /etc/apt/sources.list /etc/apt/sources.list.old
        cp $current_path/sources.list_t /etc/apt/sources.list
        rm $current_path/sources.list_t
        #update
        apt-get update
    fi
else
    echo "不支持的系统版本$TLS_name"
    read -s -n1 -t 5 -p "按任意键退出..."
    exit 1
fi
#********************************I_SOURCE END******************************************

#********************************I_GCC_GDB******************************************
if conmand -v gcc > /dev/null 2>&1; then
    echo "find gcc,skip..."
else
    echo "cant find gcc,installing..."
    apt-get install gcc
fi
if conmand -v gdb > /dev/null 2>&1; then
    echo "find gdb,skip..."
else
    echo "cant find gdb,installing..."
    apt-get install gdb
fi
if conmand -v make > /dev/null 2>&1; then
    echo "find make,skip..."
else
    echo "cant find make,installing..."
    apt-get install make
fi
if conmand -v wget > /dev/null 2>&1; then
    echo "find wget,skip..."
else
    echo "cant find wget,installing..."
    apt-get install wget
fi
if conmand -v tar > /dev/null 2>&1; then
    echo "find tar,skip..."
else
    echo "cant find tar,installing..."
    apt-get install tar
fi
if conmand -v git > /dev/null 2>&1; then
    echo "find git,skip..."
else
    echo "cant find git,installing..."
    apt-get install git
fi
#********************************I_GCC_GDB END******************************************

#********************************I_PROXYCHAIN******************************************
if conmand -v proxychains > /dev/null 2>&1; then
    echo "find proxychains,skip..."
else
    echo "cant find proxychains,installing..."
    apt-get install proxychains
    wget https://github.com/lavender37/vimrc/blob/master/WSL/proxychains.conf -P /etc/proxychains.conf
fi
#********************************I_PROXYCHAIN END******************************************



#********************************I_PYTHON******************************************
if conmand -v python3 > /dev/null 2>&1; then
    #找到python3
    echo "find python3 >> $(python3 -V)"
    if [$(echo $(python3 -V) | awk -F. '{print("%d.%d.%d\n",$1,$2,$3);}') < 3.7.5]; then
        #找到的python<3.7.5则安装python3 
        wget https://github.com/lavender37/vimrc/blob/master/WSL/Python-3.7.5.tgz -P $current_path
        tar -xzvf $current_path/Python-3.7.5.tgz
        $current_path/Python-3.7.5/configure
        make && make install
        sudo cp /usr/bin/python3 /usr/bin/python
    fi
else
    echo "cant find python,installing..."
    wget https://github.com/lavender37/vimrc/blob/master/WSL/Python-3.7.5.tgz -P $current_path
    tar -xzvf $current_path/Python-3.7.5.tgz
    $current_path/Python-3.7.5/configure
    make && make install
    sudo cp /usr/bin/python3 /usr/bin/python
fi
#********************************I_PYTHON END******************************************


#********************************I_JAVA******************************************
#********************************I_JAVA END******************************************
