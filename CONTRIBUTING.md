# 贡献指南（CONTRIBUTING）

> 团队 3 协作约定。提 PR 前先读这份。

## 1. 分支命名

- 开发任务：`feature/<issue编号>-<简短描述>`，例：`feature/T-S2-04-question-post`
- 缺陷修复：`fix/<issue编号>-<问题简述>`，例：`fix/T-S2-10-vote-delta`
- 文档：`docs/<主题>`
- 工程配置：`chore/<主题>`
- **禁止直推 `main`**，所有改动走 PR。

## 2. Commit 规范（Conventional Commits 精简版）

格式：`type(scope): 描述`

- `feat(qa): 实现 Question.post`
- `fix(reputation): 修复改票增量计算`
- `docs(team): 补充 Sprint 0 会议纪要`
- `test(qa): 补充边界用例`
- `chore(ci): 新增 skeleton-check`

一个 commit 只做一件事；描述用中文短句，不写废话。

## 3. PR 规范

- 标题同 commit 格式；
- 描述必须填写 PR 模板（自动带出）；
- 一个 PR 只做一件事，改动行数 < 400；
- 关联 Issue：正文写 `Closes #<编号>`；
- 合并方式只用 **Squash**。

## 4. 评审 SLA

- PR 提出后 **24 小时内**必须有人响应（review 或评论）；
- 作者收到意见后 **24 小时内**处理或回复；
- 至少 1 名队友 approve（LGTM）才能合并。

## 5. 如何本地验证

```bash
# 后端：先跑本 Issue 指定的验收命令，再视情况全量
cd backend && mvn test -pl <module>

# 架构约束
mvn test -pl co-bootstrap -Dtest=ArchitectureTest

# 前端
cd frontend && npm run typecheck && npm run build
```

## 6. 如何求助

1. 卡住超过 4 小时：在 Issue 评论阻塞原因并 @SM，不许闷头死磕；
2. 环境问题：先跑 `bash scripts/verify-env.sh`，把输出贴到群里；
3. 需求不清：找 PO，不要自己猜；
4. 非缺陷类问题走 Discussions，不开 Issue。
