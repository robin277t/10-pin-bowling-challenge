//Frame class is a constructor that creates objects that represent each frame of bowling played.
//Instatiates with 4 variables used to store data on itself:
//3 go1, go2, flag, and total. Upon creating a new instance requires 2 arguments which are go1 and go2.
//go1 / go2 are self explanatory, representing the 2 typical rolls of a frame.
//'flag' is used as an extra data field which stores the frame type, 0 = non-bonus round, -1 = spare, and -2 = strike. Initialises as default 0
//'total' is a numeric field which defaults as 0 on creation, and is added to once round score is ascertained.
//method assignBonusflag checks for bonification potential, if it finds it it flags that for future, otherwise populates total correctly
//this assignBonusFlag must not be called on round 10 input
//It is also used on the 10th round to store a potential third go if needed (Assign flag not required on 10th round so don't call it then)
//Once scores or bonuses have been processed, this flag is changed to represent that.

class Frame {
  constructor(go1, go2) {
    this.go1 = go1;
    this.go2 = go2;
    this.flag = 0;
    this.total = 0;
  }

  assignBonusFlag() {
    if (this.go1 === 10) {
        this.flag = -2;
        return
    } else if (this.go1 + this.go2 === 10) {
        this.flag = -1;
        return
    } else {
      this.total = this.go1 + this.go2;
    }
  }
}

module.exports = Frame;
