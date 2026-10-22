#!/usr/bin/env bash
# 环境自检脚本：S0 每人跑一次，输出贴到 docs/05-质量/环境验证记录.md
set -u
fail=0

echo "== 1. JDK =="
java -version 2>&1 | head -1 || { echo "❌ 未安装 JDK"; fail=1; }

echo "== 2. Maven =="
mvn -v 2>/dev/null | head -1 || { echo "❌ 未安装 Maven"; fail=1; }

echo "== 3. Node =="
node -v 2>/dev/null || { echo "❌ 未安装 Node"; fail=1; }

echo "== 4. Docker =="
docker version --format '{{.Server.Version}}' 2>/dev/null || { echo "❌ Docker 未运行"; fail=1; }

echo "== 5. 编译后端 =="
( cd backend && mvn -q -B -DskipTests compile ) && echo "✅ 编译通过" || { echo "❌ 编译失败"; fail=1; }

echo "== 6. 前端依赖 =="
( cd frontend && npm install --no-audit --no-fund --silent ) && echo "✅ 前端依赖安装完成" || { echo "❌ 前端依赖失败"; fail=1; }

if [ "$fail" -eq 0 ]; then
  echo "✅ 环境自检通过，可以开始干活"
else
  echo "❌ 有项目未通过，请按提示修复后再跑"
  exit 1
fi
