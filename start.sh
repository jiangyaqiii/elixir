#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 脚本保存路径
SCRIPT_PATH="$HOME/ElixirV3.sh"

# 检查并安装Docker
if ! command -v docker &> /dev/null; then
    echo "未检测到 Docker，正在安装..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    echo "Docker 已安装。"
else
    echo "Docker 已安装。"
fi


# 节点安装功能

# 提示用户输入环境变量的值
# read -p "请输入验证者节点设备的IP地址: " ip_address
# read -p "请输入验证者节点的显示名称: " validator_name
# read -p "请输入验证者节点的奖励收取地址: " safe_public_address
# read -p "请输入签名者私钥,无需0x: " private_key

# 将环境变量保存到 validator.env 文件
cat <<EOF > validator.env
ENV=testnet-3

STRATEGY_EXECUTOR_IP_ADDRESS=${ip_address}
STRATEGY_EXECUTOR_DISPLAY_NAME=${validator_name}
STRATEGY_EXECUTOR_BENEFICIARY=${safe_public_address}
SIGNER_PRIVATE_KEY=${private_key}
EOF

echo "环境变量已设置并保存到 validator.env 文件。"

# 拉取 Docker 镜像
docker pull elixirprotocol/validator:v3

# 默认运行
docker run -it -d \
    --env-file validator.env \
    --name elixir \
    elixirprotocol/validator:v3

cd
rm start.sh
