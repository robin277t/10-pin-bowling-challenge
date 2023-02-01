const frameFile = require("./frame");

describe("frame class tests", () => {
  it("creates a frame with correct variable assignment", () => {
    const testFrame = new frameFile(7, 2);
    expect(testFrame.go1).toBe(7);
    expect(testFrame.go2).toBe(2);
  });

  it("leaves flag at 0 on assignFlag call with 7 and 2 and adds total", () => {
    const testFrame = new frameFile(7, 2);
    testFrame.assignBonusFlag();
    expect(testFrame.flag).toBe(0);
    expect(testFrame.total).toBe(9);
  });
  it("sets flag to -1 on assignFlag call with go2 is a spare", () => {
    const testFrame = new frameFile(2, 8);
    testFrame.assignBonusFlag();
    expect(testFrame.flag).toBe(-1);
    expect(testFrame.total).toBe(0);
  });
  it("sets flag to 0 on assignFlag call with go1 as strike", () => {
    const testFrame = new frameFile(10, 0);
    testFrame.assignBonusFlag();
    expect(testFrame.flag).toBe(-2);
    expect(testFrame.total).toBe(0);
  });
});
