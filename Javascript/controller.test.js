// const jestTest = require("../basic-tests/add");
const controller = require("./controller");
// const playerRoundConstruct = require("./playerRound");
// const frameConstruct = require("./frame");
// const input = require("./input");

jest.mock("./controller");
//DO I ALSO NEED TO MOCK ANY OTHER NEW CLASS INSTANCES CALLED BY MY MOCK? 

describe("controller initiates game conditions integration tests", () => {
  beforeEach(() => {
    // runTest = new controller();
    mockRunTest = new controller()
    controller.mockClear();
  });
  it("takes player name input and instantiates playerGame", () => {
    mockRunTest.getUserInput.mockImplementation(
      () => (mockRunTest.input0 = "Player2")
    );
    expect(mockRunTest.getUserInput()).toBe("Player2");
    expect(mockRunTest.input0).toBe("Player2");

    //TODO mock prompt-sync input
    mockRunTest.createGame();
    expect(mockRunTest.input0).toBe("Player2");
    // expect(mockRunTest.playerGame.frames).toEqual([]);
  });

  xit("runsgame correctly", () => {
    const mockInputClass = { getScore1: () => 8, getScore2: () => 2 };
    runTest.getUserInput();
    runTest.createGame();
    runTest.runGame(mockInputClass);
    expect(runTest.playerGame.frames.length).toBe(10);
  });
});
