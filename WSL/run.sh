#/usr/bin/bash

I_SOURCE="false"
I_PROXYCHAIN="false"
I_GCC_GDB="false"
I_PYTHON="true"
I_JAVA="false"

#********************************I_SOURCE******************************************
TLS_name=$(awk '{print $1}' /etc/issue) #Ubuntu
TLS_version=$(awk '{print $2}' /etc/issue) #18.04.4

current_path=$(dirname "$0")

cd current_path

#检查系统是否支持
if [ ${I_SOURCE,,} = "true" ]; then
    if [ ${TLS_name^} = "Ubuntu" ]; then
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
        if [ ! -f $current_path/sources.list ]; then
            echo "cant find template sources.list,downlaoding...."
            wget https://github.com/lavender37/vimrc/blob/master/WSL/sources.list -P $current_path
        fi
        cp $current_path/sources.list $current_path/sources.list_t
        sed -i 's/apt_template/'$apt_template'/g' "$current_path/sources.list_t"
        #backup source and update
        if [ -f /etc/apt/sources.list ]; then
            echo "backing up the /etc/apt/sources.list >> /etc/apt/sources.list.old"
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
fi
#********************************I_SOURCE END******************************************

#********************************I_GCC_GDB******************************************
if [ ${I_GCC_GDB,,} = "true" ];then
    if command -v gcc > /dev/null 2>&1; then
        echo "find gcc,skip..."
    else
        echo "cant find gcc,installing..."
        apt-get install gcc
    fi
    if command -v gdb > /dev/null 2>&1; then
        echo "find gdb,skip..."
    else
        echo "cant find gdb,installing..."
        apt-get install gdb
    fi
    if command -v make > /dev/null 2>&1; then
        echo "find make,skip..."
    else
        echo "cant find make,installing..."
        apt-get install make
    fi
    if command -v wget > /dev/null 2>&1; then
        echo "find wget,skip..."
    else
        echo "cant find wget,installing..."
        apt-get install wget
    fi
    if command -v tar > /dev/null 2>&1; then
        echo "find tar,skip..."
    else
        echo "cant find tar,installing..."
        apt-get install tar
    fi
    if command -v git > /dev/null 2>&1; then
        echo "find git,skip..."
    else
        echo "cant find git,installing..."
        apt-get install git
    fi
fi
#********************************I_GCC_GDB END******************************************

#********************************I_PROXYCHAIN******************************************
if [ ${I_PROXYCHAIN,,} = "true"  ];then
    if command -v proxychains > /dev/null 2>&1; then
        echo "find proxychains,skip..."
    else
        echo "cant find proxychains,installing..."
        apt-get install proxychains
        wget https://github.com/lavender37/vimrc/blob/master/WSL/proxychains.conf -P /etc/proxychains.conf
    fi
fi
#********************************I_PROXYCHAIN END******************************************



#********************************I_PYTHON***************************未完成***************
if [ ${I_PYTHON,,} = "true" ];then
    if command -v python3 > /dev/null 2>&1; then
        #找到python3
        echo "find python3 >> $(python3 -V)"
        if [ $(echo $(python3 -V) | awk -F " " '{printf("%s\n3.7.5",$2);}' | sort -V | head -n 1) != "3.7.5" ]; then
            #找到的python<3.7.5则安装python3
            if [ ! -f $current_path/Python-3.7.5.tgz ]; then
                wget https://github.com/lavender37/vimrc/blob/master/WSL/Python-3.7.5.tgz -P $current_path
            fi
            tar -xzvf $current_path/Python-3.7.5.tgz -C $current_path/
            if [ ! -f $current_path/Python-3.7.5/configure ]; then exit 1; fi
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
fi
#********************************I_PYTHON END******************************************


#********************************I_JAVA******************************************
#********************************I_JAVA END******************************************
