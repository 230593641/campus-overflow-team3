# 完成的定义（Definition of Done, DoD）

> 一个任务只有同时满足以下 9 条才算"做完"，缺一不可。

| # | 标准 | 自检方式 |
| --- | --- | --- |
| 1 | 代码已合并到 main | PR 已 merge |
| 2 | 单元测试通过，领域层覆盖率 ≥70% | `mvn test` + JaCoCo 报告 |
| 3 | CI 全绿（骨架检查必绿，全量测试按 Sprint 递减） | Actions 页面 |
| 4 | 至少 1 名队友 LGTM | PR Review |
| 5 | Gherkin 验收标准全部通过 | 对照 `.feature` 文件逐条勾 |
| 6 | 已部署到测试环境并通过冒烟 | `/actuator/health` 返回 UP |
| 7 | OpenAPI 契约同步更新 | `docs/api/openapi.yaml` diff |
| 8 | 涉及架构决策的已写 ADR | `docs/03-设计/ADR-0xx` |
| 9 | 用户文档与 README 已更新 | diff 检查 |

## 说明

- 第 2 条的覆盖率门槛在 S2 起逐步收紧到 0.70；S0/S1 以"不回退现有覆盖"为准。
- 第 6 条测试环境在 S4 正式部署前，可用本地 `mvn spring-boot:run` + compose 替代并记录。
- 第 7、8 条不涉及则在 PR 模板勾选"不适用"并说明。
