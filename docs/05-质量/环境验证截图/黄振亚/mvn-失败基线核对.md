# DV1 本地 mvn test 失败基线核对

实测失败 **38** 个，与任务书基线 38 完全一致；全部根因为 `UnsupportedOperationException: TODO(Sx)：xxx 尚未实现`。

| # | 测试类 | 用例 | 类型 | 未实现的方法 |
| --- | --- | --- | --- | --- |
| 1 | DiscoveryDomainTest | singleCharacterTermsAreRejectedBecauseOfNgramTokenSize | failure | SearchQuery.terms |
| 2 | DiscoveryDomainTest | searchQueryStripsOperatorsAndPicksDefaultSort | error | SearchQuery.terms |
| 3 | DiscoveryDomainTest | jaccardRanking | error | RelatedQuestionPolicy.jaccard |
| 4 | DiscoveryDomainTest | onlyRecipientCanMarkNotificationRead | error | Notification.create |
| 5 | DiscoveryDomainTest | mentionsAreParsedDeduplicatedAndCapped | error | MentionParser.extract |
| 6 | AnswerAndVoteServiceTest | cannotVoteOnOwnContent | error | MarkdownBody.ofQuestion |
| 7 | AnswerAndVoteServiceTest | changingVoteProducesCorrectDelta | error | MarkdownBody.ofQuestion |
| 8 | AnswerAndVoteServiceTest | submitAnswerPublishesEventAndBumpsCounter | error | MarkdownBody.ofQuestion |
| 9 | AnswerAndVoteServiceTest | onlyAskerOrCourseManagerCanAccept | error | MarkdownBody.ofQuestion |
| 10 | AnswerTest | acceptedAnswerCannotBeDeletedByItsAuthor | error | MarkdownBody.ofQuestion |
| 11 | AnswerTest | strangersCannotEditOrDelete | error | MarkdownBody.ofQuestion |
| 12 | AnswerTest | onlyCourseManagerCanEndorseAndOnlyOnce | error | MarkdownBody.ofQuestion |
| 13 | QuestionTest$Accepting | otherStudentsCannotAccept | error | MarkdownBody.ofQuestion |
| 14 | QuestionTest$Accepting | courseTeacherCanAcceptOnBehalfOfAsker | error | MarkdownBody.ofQuestion |
| 15 | QuestionTest$Accepting | answerMustBelongToQuestion | error | MarkdownBody.ofQuestion |
| 16 | QuestionTest$Accepting | askerCanAcceptAnAnswerOnce | error | MarkdownBody.ofQuestion |
| 17 | QuestionTest$Accepting | deletedAnswerCannotBeAccepted | error | MarkdownBody.ofQuestion |
| 18 | QuestionTest$EditingAndDeleting | deletedQuestionCannotBeAnswered | error | MarkdownBody.ofQuestion |
| 19 | QuestionTest$EditingAndDeleting | onlyAuthorOrManagerCanEdit | error | MarkdownBody.ofQuestion |
| 20 | QuestionTest$EditingAndDeleting | askerCannotDeleteAnsweredQuestionButManagerCan | error | MarkdownBody.ofQuestion |
| 21 | QuestionTest$Posting | tagsAreNormalizedAndDeduplicated | error | Tags.names |
| 22 | VoteAndCommentTest | repliesAreLimitedToOneLevelOnSameTarget | error | Comment.post |
| 23 | VoteAndCommentTest | cannotVoteOnOwnContent | failure | Vote.cast |
| 24 | VoteAndCommentTest | voteValueMustBePlusOrMinusOne | failure | Vote.cast |
| 25 | BountyAndAccountTest | sponsorCannotWinOwnBountyAndDueDetectionWorks | error | Bounty.open |
| 26 | BountyAndAccountTest | badgePolicyThresholds | error | BadgePolicy.forAcceptedCount |
| 27 | BountyAndAccountTest | onlyCourseManagerCanOpenBountyWithinLimits | failure | Bounty.open |
| 28 | BountyAndAccountTest | bountyCanBeSettledOnlyOnce | error | Bounty.open |
| 29 | BountyAndAccountTest | academicTermKeysFollowCampusCalendar | error | AcademicTerm.termKey |
| 30 | BountyAndAccountTest | freezeSpendAndRefundKeepPointsConsistent | error | ReputationAccount.open |
| 31 | ReputationRulebookTest | dailyCapLimitsOnlyPositiveVoteGains | error | ReputationRulebook.applyDailyCap |
| 32 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[1] | error | ReputationRulebook.voteDelta |
| 33 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[2] | error | ReputationRulebook.voteDelta |
| 34 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[3] | error | ReputationRulebook.voteDelta |
| 35 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[4] | error | ReputationRulebook.voteDelta |
| 36 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[5] | error | ReputationRulebook.voteDelta |
| 37 | ReputationRulebookTest | voteDeltaIsNewEffectMinusOldEffect(int, int, int)[6] | error | ReputationRulebook.voteDelta |
| 38 | ReputationRulebookTest | teachersStartWithBountyPoints | error | ReputationRulebook.initialPoints |