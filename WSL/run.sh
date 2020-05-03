TLS_name=$(awk '{print $1}' /etc/issue) #Ubuntu
TLS_version=$(awk '{print $2}' /etc/issue) #18.04.4

current_path=$(dirname "$0")

#检查系统是否支持
if [ $TLS_name != "Ubuntu" ]; then
    echo "不支持的系统版本$TLS_name"
    read -s -n1 -t 5 -p "按任意键退出..."
    exit 1
else
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
            echo "不支持的系统版本"
            read -s -n1 -t 5 -p "按任意键退出..."
            exit 1
            ;;
    esac
    if [ -f $current_path/sources.list ]; then
        wget 
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
fi

apt-get install 
apt-get install gcc

apt-get install gdb

apt-get install 
