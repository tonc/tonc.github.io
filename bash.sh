#!/bin/bash

# 获取系统架构
ARCH=$(uname -m)

install_common_services() {
    while true; do
        echo "请选择需要执行的操作："
        echo "1. update"
        echo "2. upgrade"
        echo "3. 安装openssh-server"
        echo "4. 安装vim"
        echo "5. 安装git"
        echo "6. 安装curl"
        echo "7. 安装wget"
        echo "8. 安装最新pip"
        echo "9. 一键安装上面所有"
        echo "10. 返回上一级菜单"
        read sub_choice

        case $sub_choice in
            1)
                apt update
                echo "Update complete!"
                ;;
            2)
                apt upgrade -y
                echo "Upgrade complete!"
                ;;
            3)
                apt install openssh-server -y
                sed -ri 's/^#?(PasswordAuthentication)\s+(yes|no)/\1 yes/' /etc/ssh/sshd_config
                sed -ri 's/^#?(PermitRootLogin)\s+(prohibit-password)/\1 yes/' /etc/ssh/sshd_config
                service sshd restart
                service ssh restart
                echo "openssh-server installation complete!"
                ;;
            4)
                apt install vim -y
                echo "Vim installation complete!"
                ;;
            5)
                apt install git -y
                echo "Git installation complete!"
                ;;
            6)
                apt install curl -y
                echo "Curl installation complete!"
                ;;
            7)
                apt install wget -y
                echo "Wget installation complete!"
                ;;
            8)
                python3 install python3-pip
                pip install --upgrade pip
                echo "Latest pip installation complete!"
                ;;
            9)
                apt update && apt upgrade -y && apt install openssh-server vim git curl wget -y && python3 install python3-pip && pip install --upgrade pip && curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun && sed -ri 's/^#?(PasswordAuthentication)\s+(yes|no)/\1 yes/' /etc/ssh/sshd_config && sed -ri 's/^#?(PermitRootLogin)\s+(prohibit-password)/\1 yes/' /etc/ssh/sshd_config && service sshd restart && service ssh restart
                echo "All installations complete!"
                ;;
            10)
                break
                ;;
            *)
                echo "Invalid choice, please try again!"
                ;;
        esac
    done
}

install_docker() {
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}

install_ddns-go() {
    sudo mkdir -p /usr/local/bin/ddns-go
    BIN_URL="https://github.com/jeessy2/ddns-go/releases/download/v5.2.0/ddns-go_5.2.0_linux_$ARCH.tar.gz"
    sudo wget -O /usr/local/bin/ddns-go/ddns-go.tar.gz "$BIN_URL"
    sudo tar zxvf /usr/local/bin/ddns-go/ddns-go.tar.gz -C /usr/local/bin/ddns-go/
    sudo sudo /usr/local/bin/ddns-go/ddns-go -s install

}
while true; do
    echo "请选择"
    echo "1. 安装系统服务"
    echo "2. 安装v2ray"
    echo "3. 安装docker"
    echo "4. 安装ddns-go"
    echo "5. 退出"
    read choice

    case $choice in
        1)
            install_common_services
            echo "执行完成"
            ;;
        2)
            apt install curl -y && bash <(curl -s -L https://git.io/v2ray.sh)
            echo "安装完成"
            ;;
        3)
            install_docker
            echo "docker complete!"
            ;;
        4)
            install_ddns-go
            echo "ddns-go 请访问 http://ip:8096 配置"
            ;;
        5)
            echo "Thank you for using, goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again!"
            ;;
    esac
done
