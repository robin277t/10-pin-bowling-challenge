const inputTest = require("./input");

describe("get scores from input class", () => {
  beforeEach(() => {
    inputInstance = new inputTest();
  });
  it("getScore1 works", () => {
    expect(inputInstance.getScore1()).toBeGreaterThanOrEqual(0);
    expect(inputInstance.getScore1()).toBeLessThan(11);
  });
  it("getScore2 works normal", () => {
    const testInput1 = 10 - inputInstance.getScore1();
    expect(inputInstance.getScore2()).toBeGreaterThanOrEqual(0);
    expect(inputInstance.getScore2()).toBeLessThanOrEqual(testInput1);
  });
  it("getScore2 works with round1 strike", () => {
    inputInstance.input1 = 10;
    inputInstance.roundNoInd = 6;
    expect(inputInstance.getScore2()).toBe(0);
  });
  it("getScore2 works with round1 strike in 10th frame", () => {
    inputInstance.input1 = 10;
    inputInstance.roundNoInd = 9;
    expect(inputInstance.getScore2()).toBeGreaterThanOrEqual(0);
    expect(inputInstance.getScore2()).toBeLessThan(11);
  });
});
