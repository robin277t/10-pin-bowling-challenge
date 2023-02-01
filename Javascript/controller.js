//TODO Skinnify this class as much as possible, separate out 'nice to have' formatting into separate function 'Print Out', including bringing last function in from playerRound class
//Add all user input stuff into input class, and set an option 'random' or 'user input'
//Improve frame 10 presentation stuff, and check final turkey works (not sure at the moment)
//Make nice readMe
//Run off quick untested ruby version

const playerRoundConstruct = require("./playerRound");
const frameConstruct = require("./frame");
const input = require("./input");
const prompt = require("prompt-sync")({ sigint: true });

class Run {
  constructor() {
    this.input0 = "";
  }
  getUserInput() {
    this.input0 = "Player1";
    // this.input0 = prompt("Please enter your name: "); // This line uses prompt-sync to get an input from the terminal. Disabled during testing
  }

  createGame() {
    this.playerGame = new playerRoundConstruct(this.input0);
    console.log(`Thanks ${this.input0}, let's begin`);
  }

  runGame(inputInstance) {
    while (this.playerGame.goTracker < 11) {
      const go1 = inputInstance.getScore1();
      const go2 = inputInstance.getScore2(go1);
      const newFrame = new frameConstruct(go1, go2);
      this.playerGame.addNewFrame(newFrame);

      if (this.playerGame.goTracker < 11) {
        newFrame.assignBonusFlag();
      }

      //if half strike in last round
      if (
        this.playerGame.goTracker === 11 &&
        newFrame.go1 + newFrame.go2 === 10 &&
        newFrame.go1 < 10
      ) {
        newFrame.flag = inputInstance.getScore1();
      }
      //if strike in go1 in round 10
      if (this.playerGame.goTracker === 11 && newFrame.go1 === 10) {
        newFrame.go2 = inputInstance.getScore1();
        //nested if to see if 3rd bowl is for a new strike or to complete a spare
        if (newFrame.go2 === 10) {
          newFrame.flag = inputInstance.getScore1();
        } else {
          newFrame.flag = inputInstance.getScore2(newFrame.flag);
        }
      }

      this.playerGame.calcBonusScores();
    }
  }

  displayBonusSymbols() {
    this.playerGame.frames.forEach((frame, index) => {
      //regular round strike
      if (frame.go1 === 10 && index < 9) {
        frame.go1 = "X";
        frame.go2 = "-";
      }
      //regular round spares
      if (frame.go1 + frame.go2 === 10 && frame.go1 < 10) {
        frame.go2 = "/";
      }
      //frame 10 strikes and spares
      if (frame.go1 === 10 && index === 9) {
        frame.go1 = "X";
      }
      if (frame.go1 === "X" && index === 9 && frame.go2 === 10) {
        frame.go2 = "X";
      }
      if (frame.go2 === "X" && frame.flag === 10) {
        frame.flag = "X";
      }
      if (index === 9 && frame.go2 + frame.flag === 10 && frame.go2 < 10) {
        frame.flag = "/";
      }
    });
  }

  printGameOut() {
    this.goScores = "";
    this.playerGame.frames.forEach((frame) => {
      let printGo1 = frame.go1.toString();
      let printGo2 = frame.go2.toString();
      this.goScores = this.goScores.concat(
        `| `,
        `${printGo1}`,
        " ",
        `${printGo2}`,
        " "
      );
    });

    ///The block below checks if round 10 needed a third go to complete the scorecard
    let printFlag = "";
    const r10 = this.playerGame.frames[9];
    if (
      r10.flag === 0 &&
      typeof r10.go1 === "number" &&
      typeof r10.go2 === "number" &&
      r10.go1 + r10.go2 < 10
    ) {
      printFlag = " ";
    } else {
      printFlag = r10.flag.toString();
    }
    this.goScores = this.goScores.concat(`${printFlag}`);

    this.goScores = this.goScores.concat(
      ` |   ${this.playerGame.getCurrentScore()}`
    );

    //The below statements log the vaguely formatted scorecard the way you see IRL
    console.log(
      "|--1--|--2--|--3--|--4--|--5--|--6--|--7--|--8--|--9--|--10---|--TOTAL--"
    );
    console.log(this.goScores);
    console.log(this.playerGame.getUpdatedRoundScoreString());
    console.log(`thanks for playing ${this.input0}, see you soon`);
  }
}

module.exports = Run;

//Below are commented out to disable during testing
runMe = new Run();
runMe.getUserInput();
runMe.createGame();
runMe.runGame(new input());
runMe.displayBonusSymbols();
runMe.printGameOut();
