// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackUp {
  enum PlayerQuestStatus {
    NOT_JOINED,
    JOINED,
    SUBMITTED
  }

  enum QuestReviewStatus {
    PENDING,
    REJECTED,
    APPROVED
  }

  struct Quest {
    uint256 questId;
    uint256 numberOfPlayers;
    string title;
    uint8 reward;
    uint256 numberOfRewards;
    uint256 startTime; // New field for quest start time
    uint256 endTime; // New field for quest end time
    QuestReviewStatus reviewStatus;
  }

  address public admin;
  uint256 public nextQuestId;
  mapping(uint256 => Quest) public quests;
  mapping(address => mapping(uint256 => PlayerQuestStatus)) public playerQuestStatuses;

  constructor() {
    admin = msg.sender;
  }
  
  modifier questExists(uint256 questId) {
    require(quests[questId].reward != 0, "Quest does not exist");
    _;
  }

  function createQuest(
    string calldata title_,
    uint8 reward_,
    uint256 numberOfRewards_,
    uint256 startTime_,
    uint256 endTime_
  ) external {
    require(msg.sender == admin, "Only the admin can create quests");
    require(startTime_ < endTime_, "Invalid quest start and end times");

    quests[nextQuestId].questId = nextQuestId;
    quests[nextQuestId].title = title_;
    quests[nextQuestId].reward = reward_;
    quests[nextQuestId].numberOfRewards = numberOfRewards_;
    quests[nextQuestId].reviewStatus = QuestReviewStatus.PENDING;
    quests[nextQuestId].startTime = startTime_;
    quests[nextQuestId].endTime = endTime_;
    nextQuestId++;
  }

  function joinQuest(uint256 questId) external questExists(questId) {
    require(
      playerQuestStatuses[msg.sender][questId] == PlayerQuestStatus.NOT_JOINED,
      "Player has already joined/submitted this quest"
    );
    require(
      block.timestamp >= quests[questId].startTime,
      "Quest has not started yet"
    );
    require(
      block.timestamp < quests[questId].endTime,
      "Quest has already ended"
    );

    playerQuestStatuses[msg.sender][questId] = PlayerQuestStatus.JOINED;

    Quest storage thisQuest = quests[questId];
    thisQuest.numberOfPlayers++;
  }
  
  function reviewQuestSubmission(uint256 questId, QuestReviewStatus status) external {
    require(msg.sender == admin, "Only the admin can review quest submissions");

    Quest storage thisQuest = quests[questId];
    require(thisQuest.reward != 0, "Quest does not exist");

    require(
      thisQuest.reviewStatus == QuestReviewStatus.PENDING,
      "Quest submission has already been reviewed"
    );

    thisQuest.reviewStatus = status;

    if (status == QuestReviewStatus.APPROVED) {
      // Perform the necessary actions for approved submissions
      // For example, distribute rewards to players
    } else if (status == QuestReviewStatus.REJECTED) {
      // Perform the necessary actions for rejected submissions
      // For example, notify players about the rejection
    }
  }
}
