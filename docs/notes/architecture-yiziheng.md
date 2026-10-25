# 架构理解笔记 - 易子恒

通过本地环境搭建、跑通 `mvn test`（确认 38 个红测试基线）以及成功启动前后端完成注册登录，我对项目的整体架构有了以下初步理解：

## 1. 看懂了哪些模块？

*   **六边形分层架构（以 Identity 为例）**：
    我理解了项目的物理分包结构。`co-identity-domain` 是纯 Java 写的，不依赖 Spring，负责维护业务规则；`co-identity-application` 负责用例编排（比如接收 Controller 请求，调用 domain 里的聚合根，然后通过 JPA 保存）；`co-identity-infrastructure` 则专门处理与 MySQL、Redis 等外部中间件的交互。
*   **横切机制：事务性发件箱（Outbox）**：
    在本地启动后端时，我观察到控制台每 500ms 会打印一次对 `outbox_event` 表的查询日志。结合代码，我理解了 `OutboxRelay` 定时任务的作用：应用层在保存聚合的同时，把领域事件写入 Outbox 表，然后由中继器异步投递给其他模块（如 Reputation）。这保证了跨模块事件“至少一次”投递，并且要求消费端必须幂等。
*   **环境与配置的联动**：
    我在实际启动时发现初始代码的 JDBC URL 中 `characterEncoding=utf8mb4` 会导致 Java 连接报错，需改为 `UTF-8`。同时理解了前端通过 Vite 代理将 `/api` 请求转发到后端的 8080 端口，从而打通了前后端联调。

## 2. 哪些还没看懂 / 需要后续深入？

*   **Q&A 聚合的不变式设计**：
    目前跑了 `mvn test` 发现 `co-qa-domain` 里有大量 `TODO(S1/S2)`，比如 `Question.accept()` 和 `Vote.cast()`。对于如何通过工厂方法保护聚合边界、如何优雅地抛出带有错误码（如 `QA-3001`）的 `BusinessRuleException`，我还需要下个 Sprint 重点攻克。
*   **Discovery 模块的搜索投影**：
    对 `SearchIndexProjector` 中如何保证搜索投影的幂等更新，以及中文全文检索（MySQL `ngram`）的具体实现机制，目前还比较模糊。

## 3. 总结
架构分层（依赖倒置）确实能让测试变得非常纯粹（无需启动 Spring 即可测试 domain 层）。下周进入 Sprint 1 后，我将重点攻克 `co-qa-domain` 里的问题与回答聚合，争取早日让那 38 个红测试变绿。