# 架构理解笔记 · 肖蕴晨

> 对应 Issue #55（T-S0-04），2026-10-25

## 看懂了哪些

**1. 总体结构**
后端是 27 个 Maven 模块的模块化单体，6 个限界上下文：Identity（身份）、Q&A（问答）、Reputation（声誉）、Discovery（发现），加上共享内核 Shared Kernel 和启动模块 Bootstrap。每个上下文都是标准五层：domain（领域层，纯 Java）、api（接口契约）、application（应用服务）、infrastructure（持久化适配）、interfaces（REST 层）。

**2. co-identity 是完整的参考实现**
domain 层有 User、Course、CourseMember、PasswordHasher、PasswordPolicy 等聚合，注册、选课、成员管理都实现了。这一层零框架依赖，仓储接口定义在领域层、实现在基础设施层——这是 S1 写 co-qa 时要照抄的模板。

**3. co-qa 的测试就是需求说明书**
Question、Answer、Vote、Comment、Tags、MarkdownBody、Title 的聚合骨架都在，QuestionTest / AnswerTest / VoteAndCommentTest 把 S1 要做的行为（提问、回答、投票、评论、采纳、标签归一化）全部写成了测试断言。目前失败的原因清一色是 `UnsupportedOperationException: TODO(S2) 未实现`——方法签名和不变式都留好了，我们只要按测试填实现。

**4. 8 条 ADR 有据可查**
模块化单体（为什么不选 SOA）、事务性发件箱、服务端会话、声誉账本、中文全文检索、软删除、契约优先、领域与持久化分离。ArchitectureTest 还会把其中部分规则变成可执行的检查，写代码时不能违背。

## 还没看懂的

1. **事务性发件箱（ADR-002）和服务端会话（ADR-003）的落地代码**：只在 identity infrastructure 里见到相关类，具体怎么发的消息、会话怎么管理还没细读。
2. **co-reputation 和 co-discovery**：目前只有骨架和 ADR 说明，声誉账本和全文检索的具体机制还没吃透。
3. **ArchitectureTest 的 FF-1~FF-6 规则**：知道它把 ADR 变成了可执行检查，但每一条约束什么、怎么写实现才不会踩，需要再看一遍。

## 下一步

作为 SM：先把 S0 收尾（环境验证、看板、CI 分支保护）跑顺，S1 开始后盯 co-qa 的 36 个 TODO 按测试逐步实现，保持小步提交和 review 流程。
