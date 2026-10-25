#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔍 开始验证 CampusOverflow 本地开发环境...${NC}\n"

FAILED=0

# 1. 检查 Java
if command -v java &>/dev/null; then
    JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
    if [ "$JAVA_VER" -ge 21 ]; then
        echo -e "${GREEN}✅ Java 已安装: $(java -version 2>&1 | head -n 1)${NC}"
    else
        echo -e "${RED}❌ Java 版本过低，需 JDK 21+，当前为: $JAVA_VER${NC}"
        FAILED=1
    fi
else
    echo -e "${RED}❌ 未检测到 Java，请安装 JDK 21${NC}"
    FAILED=1
fi

# 2. 检查 Maven
if command -v mvn &>/dev/null; then
    echo -e "${GREEN}✅ Maven 已安装: $(mvn -version | head -n 1)${NC}"
else
    echo -e "${RED}❌ 未检测到 Maven，请安装 Maven 3.9+${NC}"
    FAILED=1
fi

# 3. 检查 Node.js
if command -v node &>/dev/null; then
    NODE_VER=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VER" -ge 20 ]; then
        echo -e "${GREEN}✅ Node.js 已安装: $(node -v)${NC}"
        echo -e "${GREEN}✅ npm 已安装: $(npm -v)${NC}"
    else
        echo -e "${RED}❌ Node.js 版本过低，需 v20+，当前为: $(node -v)${NC}"
        FAILED=1
    fi
else
    echo -e "${RED}❌ 未检测到 Node.js，请安装 Node.js 20+${NC}"
    FAILED=1
fi

# 4. 检查 Docker
if command -v docker &>/dev/null; then
    if docker info &>/dev/null; then
        echo -e "${GREEN}✅ Docker 已安装且守护进程正在运行。${NC}"
    else
        echo -e "${RED}❌ Docker 已安装，但守护进程未启动。请打开 Docker Desktop！${NC}"
        FAILED=1
    fi
else
    echo -e "${RED}❌ 未检测到 Docker，请安装 Docker Desktop${NC}"
    FAILED=1
fi

echo -e "\n----------------------------------------"
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 环境验证全部通过！可以开始 Sprint 1 的开发了！${NC}"
    exit 0
else
    echo -e "${RED}⚠️ 环境验证未通过，请根据以上提示修复环境。${NC}"
    exit 1
fi
