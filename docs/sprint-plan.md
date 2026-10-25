# CampusOverflow Sprint 计划

> 依据：《CampusOverflow 实验指导书 V2》（2026年10月版）
> 周期：8 周，5 个 Sprint + 答辩，每个 Sprint 结束打版本标签
> Sprint 编号与仓库现有 Issue / Milestone 体系保持一致（S0–S4 + W16）

---

## 周次 → Sprint 映射

| 周次 | Sprint | 主题 | 版本标签 |
|---|---|---|---|
| 第1周 | **S0** | 启动与基础设施 | `v0.1.0` |
| 第2周 | **S1** | 读懂参考实现 + Identity 增量（选做2个） | — |
| 第3–4周 | **S2** | Q&A 问答核心（36个TODO） | `v0.2.0` |
| 第5–6周 | **S3** | 声誉（39个）+ 发现（32个） | `v0.3.0` → `v0.9.0` |
| 第7–8周 | **S4** | 稳定化、部署、可观测性 | `v1.0.0` |
| 答辩周 | **W16** | 最终演示与答辩 | — |

---

## S0：启动与基础设施（第1周）

**Sprint Goal**：团队、仓库、环境、CI 与 Product Backlog 全部就绪；每人能本地启动系统、完成注册/登录/加入课程，并完成一次"分支→PR→评审→合并"。

**关键任务**：
- 团队组建、角色确认（PO/SM/DV）
- 仓库搭建、分支保护、GitHub Projects 看板
- 每人环境验证（JDK21 + Maven + Docker）
- 每人破冰 PR（自我介绍 hello）
- 团队章程签字
- 48 个 PBI 导入看板、按 Sprint 排序
- 渐进式 CI 门禁（ADR-009）
- docs/ddd/ 上下文映射、统一语言、事件清单
- main 打标签 `v0.1.0`

**验收**：现场演示注册→登录→加入课程；Swagger 可访问；main 标签已打。

---

## S1：读懂参考实现 + Identity 增量（第2周）

**Sprint Goal**：每个人能对照代码讲清楚 Identity 上下文的每一层结构；从 #61–#63 三个 Identity 增量需求中选 2 个完成，第三个留作缓冲。

**范围**：
- #61 选课审批
- #62 个人资料编辑
- #63 课程成员管理

三个选两个做，第三个按剩余容量在 S4 选做。

**关键任务**：
- 通读 co-identity 五层（api/domain/application/infrastructure/interfaces）
- 读懂发件箱、Actor、CSRF、字段加密等横切机制
- 选 2 个 Identity 增量需求，按 PR 流程实现
- 行走骨架准备：Discovery/Reputation 监听器临时空实现

**验收**：每人能讲清 Identity 代码结构；2 个 Identity 增量需求合并；main 上 CI 保持绿。

---

## S2：Q&A 问答核心（第3–4周）

**Sprint Goal**：前端完成"提问→回答→投票→评论→采纳"完整闭环，教师可认证与删除；Q&A 领域层+应用层测试全绿。

**范围**：co-qa 全部 36 个 TODO 方法（对应 Issue #25–#36）。

**关键任务**：
- Question / Answer / Comment 聚合实现
- 提问、回答、评论（一层回复）
- 投票、改投、撤销
- 采纳最佳答案（核心场景 R-2）
- 教师认证、删除（软删除）
- 行走骨架：Discovery/Reputation 的监听器临时空实现
- 前端：问题列表、详情、提问表单

**验收**：mvn test 在 co-qa 全绿；ArchitectureTest 通过；npm typecheck+build 通过；现场演示完整闭环；main 打标签 `v0.2.0`。

---

## S3：声誉与发现（第5–6周）

**Sprint Goal**：问答行为异步、幂等地转化为声誉、徽章、悬赏、排行榜；中文搜索、相关推荐、通知/@提醒可用；移除全部行走骨架；mvn verify（含 Testcontainers 端到端）在 CI 全绿。

**范围**：
- co-reputation 全部 39 个 TODO（Issue #37–#48）
- co-discovery 全部 32 个 TODO（Issue #49–#51 及后续）

**关键任务**：
- 声誉账本（流水原子更新、幂等）
- 投票计分（赞+10、踩-2、赞改踩-12、日上限200）
- 徽章系统、悬赏（发起/冻结/结算/到期退款）
- 排行榜（周/月/学期/总榜，Redis ZSET）
- 对账接口（admin/reconciliation）
- 中文全文检索（ngram + 停用词）
- 相关问题推荐（相似度）
- 通知中心（回答/采纳/认证/悬赏/徽章/@）
- 移除全部行走骨架
- 端到端集成测试 CampusOverflowFlowIT 通过
- 覆盖率门禁升至 70%
- CI 全 5 个后端阶段 + 前端阶段绿；镜像构建成功

**验收**：采纳后数秒内声誉+15；搜索"跳表"命中；通知全链路可达；CI 全绿；main 打标签 `v0.9.0`。

---

## S4：稳定化与发布（第7–8周）

**Sprint Goal**：不破坏质量门禁的前提下打磨体验、补可观测性，完成 v1.0.0 发布与答辩；按剩余容量完成 Identity 第三个增量需求。

**关键任务**：
- 按 PO 优先级完成 Backlog 中 Could 项
- 可观测性（Prometheus + Grafana）
- 生产部署验证（docker compose）
- GitHub Release + 镜像推送到 GHCR
- 最终答辩（15分钟演示脚本）

**验收**：v1.0.0 标签；答辩演示通过；CI 持续绿。

---

## 与实验指导书 V2 的对应关系

| 指导书 V2 叫法 | 仓库现有编号 | 说明 |
|---|---|---|
| Sprint 0（启动） | S0 | 一致 |
| Sprint 1（问答核心） | S2 | 问答核心在仓库编号中是 S2 |
| Sprint 2（声誉） | S3 前半 | 声誉+发现合并为 S3 |
| Sprint 3（发现+端到端） | S3 后半 | 同上 |
| Sprint 4（发布） | S4 | 一致 |
| — | S1 | 读懂 Identity + 增量选做 |

> 本计划保留仓库现有 Sprint 编号，不改动已有 Issue 的 milestone 和标签。
