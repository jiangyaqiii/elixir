#!/bin/bash
# 节点安装功能
# 提示用户输入环境变量的值
# read -p "请输入验证者节点设备的IP地址: " ip_address
ip_address=$(curl -s4 ifconfig.me/ip)

# 将环境变量保存到 validator.env 文件
cat <<EOF > validator.env
ENV=testnet-3

STRATEGY_EXECUTOR_IP_ADDRESS=${ip_address}
STRATEGY_EXECUTOR_DISPLAY_NAME=${validator_name}
STRATEGY_EXECUTOR_BENEFICIARY=${safe_public_address}
SIGNER_PRIVATE_KEY=${private_key}
EOF

echo "环境变量已设置并保存到 validator.env 文件。"


docker_id=$(docker ps | grep "elixir" | awk '{print $1}')
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
rm start.sh
