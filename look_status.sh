#!/bin/bash

if [[ $(docker ps -qf name=elixir) ]]; then
    echo "elixir正在运行"
else
    echo "停止"
fi
