# 架构理解笔记 - 孔志敏

通过拉取团队仓库、跑通 mvn test（确认 38 个红测试基线）以及阅读代码，我对项目架构有了以下理解：

## 1. 看懂了哪些模块

**多模块 Maven 结构**：项目按业务上下文拆成多个模块——co-identity、co-qa、co-reputation、co-discovery。每个模块内部又分 domain / application / infrastructure / interfaces 四层，依赖方向严格从外向内。domain 层是纯 Java，不依赖 Spring，可以独立测试。

**六边形架构落地**：以 co-identity 为例，domain 层定义了 User/Student/Teacher 等聚合根和领域事件；application 层编排用例（注册、登录、选课）；infrastructure 层用 JPA 实现持久化、用 Redis 存 token；interfaces 层是 REST Controller。外部请求只进 interfaces，不直接碰 domain。

**事务性发件箱（Outbox）**：应用层保存聚合时同时写 outbox_event 表，OutboxRelay 定时任务每 500ms 扫描并投递给其他模块。这保证了跨模块事件的"至少一次"投递，消费端必须幂等。

**前端联调**：Vite 把 /api 代理到后端 8080 端口，前端用 React + Tailwind，后端用 Spring Boot 3。

## 2. 哪些还没看懂 / 需要深入

**Q&A 聚合的不变式**：Question 怎么控制"只有提问者能编辑、只有教师能删除"？Vote 的方向怎么保证不能重复投？这些 TODO 方法（Question.accept()、Vote.cast()）要在 S2 攻克。

**中文搜索实现**：co-discovery 的 SearchIndexProjector 怎么保证搜索投影幂等更新？MySQL ngram 分词的具体配置还没细看。

**CI 门禁策略**：skeleton-check 和 ci.yml 的关系——日常 PR 只跑 skeleton-check（快），合并到 main 才跑全量 ci.yml，这个设计理解了但具体配置还要再看。

## 3. 总结

分层架构让 domain 层测试非常纯粹（不用启 Spring），这对后续写 Q&A 的单测很友好。S2 开始我会重点看 co-qa-domain 的 TODO，把提问/回答/投票的聚合边界搞清楚。
