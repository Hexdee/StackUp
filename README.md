# New features

I added two features to the existing StackUp smart contract which are:

- Quest Review functionality
- Quest Start and End Time

## Quest Review Functionality

The quest review functionality was chosen to enhance the smart contract's capabilities by introducing an approval and rejection process for quest submissions. This feature provides greater control to the admin in managing quests and ensures that only valid and appropriate submissions are approved.

The feature works by adding a `QuestReviewStatus` field to the `Quest` struct. When a quest is created, its review status is set to `PENDING` by default. The admin can then use the `reviewQuestSubmission` function to update the review status of a quest submission. The admin can choose to reject or approve a quest submission based on their evaluation.

This feature empowers the admin to review and manage quest submissions effectively, ensuring the quality and validity of completed quests before rewarding users.

## Quest Start and End Time

The quest start and end time feature was implemented to provide better control and management of quests by specifying their duration. This ensures that users can only join quests within the designated timeframe and prevents participation in quests that have already ended.

When creating a quest, the admin sets the start and end times for the quest. When a user attempts to join a quest using the `joinQuest` function, the smart contract checks if the current block timestamp is within the quest's start and end times. If the quest has not started yet or has already ended, the user will receive an error message, indicating that they cannot join the quest.

This feature adds an element of time sensitivity to quests, creating a more dynamic and time-constrained quest environment where users must act within the specified timeframe to participate and complete quests.
