const playerRoundFile = require("./playerRound");

describe("creating new PlayerGame instances and adding new frames", () => {
  beforeEach(() => {
    testGame = new playerRoundFile("Jeff");
  });
  it("create with playerName works correctly", () => {
    expect(testGame.playerName).toBe("Jeff");
  });
  it("create plus add of 1 mocked frame works correctly & updates goTracker", () => {
    const mockFrame = { go1: 6, go2: 2 };
    expect(testGame.goTracker).toBe(1);
    expect(testGame.frames.length).toBe(0);
    testGame.addNewFrame(mockFrame);
    expect(testGame.goTracker).toBe(2);
    expect(testGame.frames.length).toBe(1);
  });
  it("create plus add of 2 mocked frames works correctly & updates goTracker", () => {
    const mockFrame1 = { go1: 6, go2: 2 };
    const mockFrame2 = { go1: 4, go2: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    expect(testGame.goTracker).toBe(3);
    expect(testGame.frames.length).toBe(2);
  });
});

describe("bonus and score calculations up to and including round 8", () => {
  beforeEach(() => {
    testGame = new playerRoundFile("Jeff");
  });
  it("getCurrentScore works with 3 standard frames", () => {
    const mockFrame1 = { go1: 6, go2: 2, total: 8 };
    const mockFrame2 = { go1: 4, go2: 0, total: 4 };
    const mockFrame3 = { go1: 0, go2: 3, total: 3 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    expect(testGame.getCurrentScore()).toBe(15);
  });
  it("getCurrentScore works with 2 Strikes and 1 missing frame score", () => {
    const mockFrame1 = { go1: 10, go2: 0, total: 26 };
    const mockFrame2 = { go1: 10, go2: 0, total: 20 };
    const mockFrame3 = { go1: 6, go2: 4, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    expect(testGame.getCurrentScore()).toBe(46);
  });

  it("calcBonusRoundsUnder10 works with 1 spare frame only", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(0);
  });
  it("calcBonusRoundsUnder10 works with 1 Strike frame only", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(0);
  });

  it("calcBonusRoundsUnder10 works with 1 spare frame followed by 1 standard frame", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    const mockFrame2 = { go1: 7, go2: 0, flag: 0, total: 7 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(24);
  });

  it("calcBonusRoundsUnder10 works with 1 spare frame followed by 1 spare frame", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    const mockFrame2 = { go1: 7, go2: 3, flag: -1, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(17);
  });

  it("calcBonusRoundsUnder10 works with 1 spare > 1 spare > 1 standard frames AND checks spare flag reset", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    const mockFrame2 = { go1: 7, go2: 3, flag: -1, total: 0 };
    const mockFrame3 = { go1: 2, go2: 0, flag: 0, total: 2 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(31);
    expect(mockFrame2.flag).toBe(0);
  });

  it("calcBonusRoundsUnder10 works with 1 spare > 1 standard > 1 spare frames", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    const mockFrame2 = { go1: 2, go2: 0, flag: 0, total: 2 };
    const mockFrame3 = { go1: 7, go2: 3, flag: -1, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(14);
  });

  it("calcBonusRoundsUnder10 works with 1 spare > 1 Strike >", () => {
    const mockFrame1 = { go1: 6, go2: 4, flag: -1, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(20);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 standard frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 7, go2: 2, flag: 0, total: 9 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(28);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 spare frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 7, go2: 3, flag: -1, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(20);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 spare > 1 standard frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 7, go2: 3, flag: -1, total: 0 };
    const mockFrame3 = { go1: 7, go2: 2, flag: 0, total: 9 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(46);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 spare > 1 Strike frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 7, go2: 3, flag: -1, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(40);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 standard > 1 Strike frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 7, go2: 0, flag: 0, total: 7 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(24);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 Strike > 1 standard frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 4, go2: 4, flag: 0, total: 8 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(50);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 Strike > 1 Strike frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(30);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 Strike > 1 Strike > 1 spare frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame4 = { go1: 5, go2: 5, flag: -1, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.addNewFrame(mockFrame4);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(75);
  });

  it("calcBonusRoundsUnder10 works with 1 Strike > 1 Strike > 1 Strike > 1 spare > 1 standard frames", () => {
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame4 = { go1: 5, go2: 5, flag: -1, total: 0 };
    const mockFrame5 = { go1: 5, go2: 1, flag: 0, total: 6 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.addNewFrame(mockFrame4);
    testGame.addNewFrame(mockFrame5);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(96);
  });
});

describe("bonus and score calculations rounds 8 through 10", () => {
  beforeEach(() => {
    testGame = new playerRoundFile("Jeff");
    //   ROUNDS 1 - 7 mocked frames here (total points 105)
    const mockFrame1 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame4 = { go1: 5, go2: 5, flag: -1, total: 0 };
    const mockFrame5 = { go1: 5, go2: 1, flag: 0, total: 6 };
    const mockFrame6 = { go1: 0, go2: 0, flag: 0, total: 0 };
    const mockFrame7 = { go1: 2, go2: 2, flag: 0, total: 4 };
    // ROUNDS 1 - 7 added here
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.addNewFrame(mockFrame4);
    testGame.addNewFrame(mockFrame5);
    testGame.addNewFrame(mockFrame6);
    testGame.addNewFrame(mockFrame7);
  });

  it("calcBonusEnd handles strike in 8, strike in 9", () => {
    const mockFrame8 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(100);
  });

  it("calcBonusEnd handles strike in 8, strike in 9, standard in 10", () => {
    const mockFrame8 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 3, go2: 2, flag: 0, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(143);
  });

  it("calcBonusEnd handles spare in 8, strike in 9, standard in 10", () => {
    const mockFrame8 = { go1: 7, go2: 3, flag: -1, total: 0 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 3, go2: 2, flag: 0, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(140);
  });

  it("calcBonusEnd handles spare in 8, spare in 9, standard in 10", () => {
    const mockFrame8 = { go1: 7, go2: 3, flag: -1, total: 0 };
    const mockFrame9 = { go1: 4, go2: 6, flag: -1, total: 0 };
    const mockFrame10 = { go1: 3, go2: 2, flag: 0, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(132);
  });

  it("calcBonusEnd handles standard in 8, standard in 9, standard in 10", () => {
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 4, go2: 3, flag: 0, total: 7 };
    const mockFrame10 = { go1: 3, go2: 2, flag: 0, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(120);
  });

  it("calcBonusEnd handles standard in 8, strike in 9, spare in 10 + extra 5", () => {
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 3, go2: 7, flag: 5, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(143);
  });
  it("calcBonusEnd handles standard in 8, strike in 9, strike in 10 + extra 5 + extra 3", () => {
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 3, go2: 7, flag: 5, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(143);
  });

  it("calcBonusEnd handles standard in 8, spare in 9, strike in 10 + strike + extra 4", () => {
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 3, go2: 7, flag: -1, total: 0 };
    const mockFrame10 = { go1: 10, go2: 10, flag: 4, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(152);
  });

  it("calcBonusEnd handles standard in 8, strike in 9, strike in 10 + extra strike + extra strike", () => {
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 10, go2: 10, flag: 10, total: 0 };
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getCurrentScore()).toBe(168);
  });
});
describe("printing collected scores for terminal use", () => {
  it("getUpdatedRoundScoreString returns correctly", () => {
    testGame = new playerRoundFile("Jeff");
    const mockFrame1 = { go1: 0, go2: 0, flag: 0, total: 0 };
    const mockFrame2 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame3 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame4 = { go1: 5, go2: 5, flag: -1, total: 0 };
    const mockFrame5 = { go1: 5, go2: 1, flag: 0, total: 6 };
    const mockFrame6 = { go1: 0, go2: 0, flag: 0, total: 0 };
    const mockFrame7 = { go1: 2, go2: 2, flag: 0, total: 4 };
    const mockFrame8 = { go1: 7, go2: 1, flag: 0, total: 8 };
    const mockFrame9 = { go1: 10, go2: 0, flag: -2, total: 0 };
    const mockFrame10 = { go1: 10, go2: 10, flag: 10, total: 0 };
    testGame.addNewFrame(mockFrame1);
    testGame.addNewFrame(mockFrame2);
    testGame.addNewFrame(mockFrame3);
    testGame.addNewFrame(mockFrame4);
    testGame.addNewFrame(mockFrame5);
    testGame.addNewFrame(mockFrame6);
    testGame.addNewFrame(mockFrame7);
    testGame.addNewFrame(mockFrame8);
    testGame.addNewFrame(mockFrame9);
    testGame.addNewFrame(mockFrame10);
    testGame.calcBonusScores();
    expect(testGame.getUpdatedRoundScoreString()).toBe(
      "| 0   | 25  | 45  | 60  | 66  | 66  | 70  | 78  | 108 | 138 "
    );
  });
});
