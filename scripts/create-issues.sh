#!/usr/bin/env bash
# 从 docs/07-任务/tasks.tsv 批量创建 32 个开发任务 Issue
# 前置：gh auth status 已登录；标签与里程碑已创建（顺序不能反）
set -euo pipefail
REPO="230593641/campus-overflow-team3"
TSV="docs/07-任务/tasks.tsv"

# Sprint -> 里程碑
milestone_of() {
  case "$1" in
    S2) echo "S2 问答核心" ;;
    S3) echo "S3 声誉与发现" ;;
    *)  echo "" ;;
  esac
}

tail -n +2 "$TSV" | while IFS=$'\t' read -r id title sprint module file methods deps hours verify; do
  [ -z "${id:-}" ] && continue
  layer="layer/domain"
  [[ "$file" == *"application"* ]] && layer="layer/application"

  body=$(cat <<EOF
## 任务信息
- 任务ID：$id
- Sprint：$sprint
- 模块：$module
- 文件：\`$file\`
- 方法：$methods
- 前置任务：$deps
- 预估工时：${hours}h

## 验收命令
\`\`\`bash
$verify
\`\`\`

## 完成标准
- [ ] 验收命令全绿
- [ ] 文件内无 \`TODO($sprint)\` 残留
- [ ] PR 已通过 1 人评审
- [ ] 看板已移到「已完成」

## 参考
- 规格说明：同模块 \`src/test\` 下对应测试类
- 任务总表：\`docs/07-任务/107任务拆解表.md\`
EOF
)

  gh issue create \
    --repo "$REPO" \
    --title "[$id] $title" \
    --body "$body" \
    --label "type/task" \
    --label "sprint/$(echo "$sprint" | tr 'A-Z' 'a-z')" \
    --label "module/$module" \
    --label "$layer" \
    --milestone "$(milestone_of "$sprint")"
done
