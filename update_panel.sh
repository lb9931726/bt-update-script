#!/bin/bash
echo "2" | bt
sync
if [ -f "/usr/bin/yum" ] && [ -f "/etc/yum.conf" ]; then
    setenforce 0
    yum install -y nss libcurl-devel openssl-devel
    yum upgrade -y nss libcurl-devel openssl-devel 
    # yum reinstall -y ca-certificates && update-ca-trust
fi

# download
curl -k -fsSL --connect-timeout 30 -m 10 https://io.bt.sb/install/update_panel.sh -o /tmp/update_panel.sh
if [ $? -ne 0 ]; then
    echo "Failed to download update script"
    exit 1
fi

# version - 强制指定为11.6.0
version='11.6.0'

sed -i '2i version="$1"' /tmp/update_panel.sh
bash /tmp/update_panel.sh "$version"
if [ $? -ne 0 ]; then
    echo "Failed to update script"
    exit 1
fi
unset http_proxy https_proxy

echo "1" | bt
echo "9" | bt
echo "4" | bt
echo "9" | bt

clear
echo -e "\033[32m==========================================\033[0m\n"
echo -e "\033[36m已成功升级到 [$version] 企业版\033[0m";
echo -e "\033[36m请退出浏览器，重新登录！\033[0m\n";
echo -e "\033[32m==========================================\033[0m\n"
