---
name: 开发任务
about: 一个文件 / 一个 PR 的开发任务
title: "[T-S2-XX] 文件名：方法列表"
labels: ["type/task"]
---

## 任务信息
- 任务ID：T-S2-XX
- Sprint：S2
- 模块：co-qa-domain
- 文件：`backend/co-qa/co-qa-domain/src/main/java/.../Question.java`
- 方法：post、edit、accept、softDelete、ensureOpenForAnswers、ensureNotDeleted
- 方法数：6
- 前置任务：T-S2-01、T-S2-02
- 预估工时：4h

## 验收命令
```bash
mvn test -pl co-qa/co-qa-domain -Dtest=QuestionTest
```

## 完成标准
- [ ] 验收命令全绿
- [ ] 文件内无 `TODO(S2)` 残留
- [ ] PR 已通过 1 人评审
- [ ] 看板已移到「已完成」

## 参考
- 规格说明：`backend/co-qa/co-qa-domain/src/test/java/.../QuestionTest.java`
- 架构文档：arc42 第 5 章
