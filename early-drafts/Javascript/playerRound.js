//Player games class creates an object that represents one players' whole game of 10 rounds.
//If the application were to allow it, multiple instances of player game can be run together to make a real life game
//Instantiates with a variable 'goTracker' which starts at 1, and a blank array called 'frames', and a blank variable string called 'playerName'
//Takes 1 argument => playerName on creation

//Methods are as follows:
//1 addNewFrame (also updates goTracker)
//2 calcBonusRoundsUnder10
//3 calcBonusEnd
//4 getCurrentScore

class PlayerRound {
  constructor(playerName) {
    this.playerName = playerName;
    this.frames = [];
    this.goTracker = 1;
  }

  addNewFrame(frame) {
    this.frames.push(frame);
    this.goTracker += 1;
  }

  //This function loops updates frame total if it needs a bonus score from a spare. Called after each frame added
  calcBonusScores() {
    this.frames.forEach((frameObj, index, arr) => {
      //This 1st 'if' test does SPARES calculation by checking for frame spare flag and that next frame exists
      if (frameObj["flag"] === -1 && arr.length > index + 1) {
        frameObj["total"] = 10 + arr[index + 1]["go1"];
        frameObj["flag"] = 0;
      }
      //This 2nd 'if' test does STRIKE calc checking for flag and that frame +1 exists and it's not also a strike
      if (
        frameObj["flag"] === -2 &&
        arr.length > index + 1 &&
        arr[index + 1]["flag"] != -2
      ) {
        frameObj["total"] = 10 + arr[index + 1]["go1"] + arr[index + 1]["go2"];
        frameObj["flag"] = 0;
      }
      //This 3rd 'if' test does DOUBLE/TURKEY calculations as above by checking strike flag and that frame + 2 exists
      if (
        frameObj["flag"] === -2 &&
        arr.length > index + 2 &&
        arr[index + 1]["flag"] === -2
      ) {
        frameObj["total"] = 10 + arr[index + 1]["go1"] + arr[index + 2]["go1"];
        frameObj["flag"] = 0;
      }
      //this last 'if' block adds up round 10 only as a special case
      if (index === 9) {
        frameObj["total"] =
          frameObj["go1"] + frameObj["go2"] + frameObj["flag"];
      }
    });
  }

  getCurrentScore() {
    let runningTotal = 0;
    this.frames.forEach((frameObj) => {
      runningTotal += frameObj["total"];
    });
    return runningTotal;
  }

  getUpdatedRoundScoreString() {
    let runningTotal = 0;
    let finalString = ""
    this.frames.forEach((frameObj) => {
      runningTotal += frameObj["total"];
      if (runningTotal < 10) {
        finalString = finalString.concat(`| ${runningTotal.toString()}   `)
      } else if (runningTotal > 99) {
        finalString = finalString.concat(`| ${runningTotal.toString()} `)
      } else{
        finalString = finalString.concat(`| ${runningTotal.toString()}  `)
    }
    });
    return finalString;
  }
}

module.exports = PlayerRound;
