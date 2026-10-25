#!/bin/bash
# River Rush 3D Pro 启动脚本
# 解决 WebGL 沙箱限制问题（本机环境需要 --no-sandbox 等参数）

GAME_URL="http://127.0.0.1:8848/river-rush-pro.html"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 检查 HTTP 服务器是否在运行
if ! curl -s -o /dev/null -w "%{http_code}" "$GAME_URL" 2>/dev/null | grep -q "200"; then
#  echo "🔄 启动本地服务器..."
  cd "$SCRIPT_DIR"
  python3 -m http.server 8848 --bind 127.0.0.1 &>/dev/null &
#  echo "  服务器已启动 (端口 8848)"
  sleep 1
fi

#echo "🚀 启动 Chrome（GPU加速模式）..."
google-chrome \
  --user-data-dir=/tmp/chrome-game-profile \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu-sandbox \
  --ignore-gpu-blocklist \
  --no-first-run \
  --no-default-browser-check \
  "$GAME_URL" &>/dev/null &

#echo "✅ 已启动！"
#echo "   如果没看到窗口，请稍等几秒。"
#echo "   关闭浏览器后可再次运行此脚本重新打开。"
