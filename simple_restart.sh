#!/bin/bash
# 节点安装功能
# 提示用户输入环境变量的值
# read -p "请输入验证者节点设备的IP地址: " ip_address
echo "================flag:v2================"
ip_address=$(curl -s4 ifconfig.me/ip)

# 将环境变量保存到 validator.env 文件

docker_id=$(docker ps | grep "elixir" | awk '{print $1}')
echo $docker_id
docker stop $docker_id
docker rm $docker_id
# 拉取 Docker 镜像
docker pull elixirprotocol/validator:v3
# 默认运行
docker run -it -d \
    --env-file validator.env \
    --name elixir \
    elixirprotocol/validator:v3

cd
rm simple_restart.sh
