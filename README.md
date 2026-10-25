# CampusOverflow · 团队 3

> 湖北文理学院《软件工程》课程贯穿项目 · 校园问答平台
> 当前阶段：**Sprint 0 已完成，进入 Sprint 1（第 3 周）** ｜ 基线版本：`v0.1.0-starter`

[![骨架检查](https://github.com/230593641/campus-overflow-team3/actions/workflows/skeleton-check.yml/badge.svg)](https://github.com/230593641/campus-overflow-team3/actions/workflows/skeleton-check.yml)

## 这是什么

一个面向校园场景的问答平台（大学版 Stack Overflow）：提问、回答、投票、采纳、声誉、搜索、通知。
本仓库是团队 3 的主仓库，基于课程提供的起始框架（27 个 Maven 模块 + React 前端 + Docker + CI）。

## 团队

| 姓名 | GitHub | 角色 | 负责上下文 | 备份 |
| --- | --- | --- | --- | --- |
| 孔志敏 | KZM-7748 | PO | 需求 / Backlog | 刘浩然 |
| 刘浩然 | 230593641 | SM | 流程 / 看板 | 肖蕴晨 |
| 肖蕴晨 | LIfe-evoe | SM | 流程 / 看板 | 刘浩然 |
| 黄振亚 | deadlie | Dev | Q&A / 测试验证 | 易子恒 |
| 易子恒 | moOvO760 | Dev | Discovery / 声誉 | 黄振亚 |

> 说明：负责上下文的最终划分以 [角色与分工](docs/01-团队/角色与分工.md) 团队确认为准。

## 本周要做什么（每周一更新）

- Sprint 目标：S1 身份内核——读懂参考实现，完成 Identity 增量需求选 2 个
- 本周重点：环境跑通、领取 S1 开发任务、DDD 事件风暴准备
- 详细计划：[docs/04-计划/Sprint1-计划.md](docs/04-计划/Sprint1-计划.md)
- 看板：[GitHub Projects](https://github.com/230593641/campus-overflow-team3/projects)

## 五分钟跑起来

```bash
# 1) 起中间件（需要 Docker）
docker compose -f deploy/docker-compose.yml up -d mysql redis

# 2) 编译并跑测试（第一次会红，这是预期的：38 个测试就是需求清单）
cd backend && mvn clean test

# 3) 启动后端（dev profile，不要加 demo）
mvn spring-boot:run -pl co-bootstrap -Dspring-boot.run.profiles=dev

# 4) 启动前端
cd ../frontend && npm install && npm run dev      # http://localhost:5173
```

接口文档：http://localhost:8080/swagger-ui.html

## 仓库地图

| 目录 | 内容 | 维护人 |
| --- | --- | --- |
| `backend/` | Spring Boot 多模块后端（27 模块） | 全体 |
| `frontend/` | React + TypeScript 前端 | 易子恒 |
| `deploy/` | Dockerfile、compose、Nginx、Prometheus | 黄振亚 |
| `docs/01-团队/` | 章程、角色、DoD、会议纪要 | SM |
| `docs/02-需求/` | 愿景、访谈、故事地图、Backlog | PO |
| `docs/03-设计/` | 上下文图、聚合清单、术语表、ADR | 架构负责人 |
| `docs/04-计划/` | Sprint 计划、风险登记册 | SM |
| `docs/05-质量/` | 评审清单、测试策略、环境验证 | QA |
| `docs/07-任务/` | 107 任务拆解表、领取规则 | SM |
| `docs/adr/` | 课程提供的 8 条架构决策 | 不动 |

## 怎么领任务（三步）

1. 打开看板，从「本周待领取」列挑一个**前置任务已完成**的 Issue；
2. 在 Issue 下评论「领取」并把自己设为 Assignee，看板卡片移到「进行中」；
3. 建分支 `feature/<issue编号>-<简短描述>`，做完跑 Issue 里的验收命令，提 PR（模板会自动带出检查清单）。

详见 [docs/07-任务/领取规则.md](docs/07-任务/领取规则.md)。

## 验收门槛

| 项目 | 要求 | 自检命令 |
| --- | --- | --- |
| 单元测试 | 全部通过 | `mvn test` |
| 领域覆盖率 | ≥ 70% | 把 `backend/pom.xml` 的 `domain.coverage.minimum` 改为 `0.70` 后 `mvn verify` |
| 架构约束 | ArchUnit 全过 | `mvn test -pl co-bootstrap -Dtest=ArchitectureTest` |
| 集成测试 | 端到端通过 | `mvn verify`（需 Docker） |
| 前端 | 类型检查与构建通过 | `cd frontend && npm run typecheck && npm run build` |
| 骨架检查 | 每次 PR 必绿 | GitHub Actions `skeleton-check` |

## 两条流水线，别搞混

| 流水线 | 现在是什么颜色 | 作用 |
| --- | --- | --- |
| `skeleton-check` | **必须绿** | 编译 + 架构约束 + 前端构建，保证结构没坏 |
| `ci.yml` | **现在是红的（预期）** | 全量测试，红的原因是有 38 个 TODO 测试未实现；每完成一个 Sprint，红色应减少 |

## 学术诚信

- 不修改任何已有测试的断言；不为通过测试而删测试；
- 允许使用 AI 辅助编码，但必须能讲清每一行代码的设计意图；
- 禁止跨团队复制代码。

## 必读材料

1. [docs/00-导航.md](docs/00-导航.md) —— 全部文档入口
2. [docs/adr/](docs/adr/) —— 8 条架构决策，理解"为什么"
3. 课程《CampusOverflow 软件架构设计文档（arc42）》第 5、6、10 章
4. [docs/错误码.md](docs/错误码.md) —— 错误码分段与 HTTP 映射
