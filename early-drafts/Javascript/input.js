class inputMain {
  constructor() {
    this.input1 = "";
    this.input2 = "";
  }
  getScore1() {
    this.input1 = Math.floor(Math.random() * 11);
    return this.input1;
  }

  getScore2(score1) {
    this.input2 = Math.floor(Math.random() * (11 - score1));
    return this.input2;
  }
}

module.exports = inputMain;
