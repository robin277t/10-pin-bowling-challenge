
Bowling Challenge - JavaScript & Ruby
=================

## The Task

- **This is primarily a bowling scorecard challenge**

- Secondary is to create a game from the command line using random rolls

- Count and sum the scores of a bowling game for one player.

- Create lean code, with classes and methods with clear responsibilities.

- A bowling game consists of 10 frames in which the player tries to knock down the 10 pins. In every frame the player can roll one or two times. The actual number depends on strikes and spares. The score of a frame is the number of knocked down pins plus bonuses for strikes and spares. After every frame the 10 pins are reset.

## To Run this App

**- In Ruby:**
- bundle install (assuming ruby is installed)
- change into sub folder './ruby' and run with command 'ruby bowling.rb'
- to run tests use command 'rspec', again in sub-folder './ruby'

## Bowling — how does it work?

### Strikes

The player has a strike if he knocks down all 10 pins with the first roll in a frame. The frame ends immediately (since there are no pins left for a second roll). The bonus for that frame is the number of pins knocked down by the next two rolls. That would be the next frame, unless the player rolls another strike.

### Spares

The player has a spare if the knocks down all 10 pins with the two rolls of a frame. The bonus for that frame is the number of pins knocked down by the next roll (first roll of next frame).

### 10th frame

If the player rolls a strike or spare in the 10th frame they can roll the additional balls for the bonus. But they can never roll more than 3 balls in the 10th frame. The additional rolls only count for the bonus not for the regular frame count.

    10, 10, 10 in the 10th frame gives 30 points (10 points for the regular first strike and 20 points for the bonus).
    1, 9, 10 in the 10th frame gives 20 points (10 points for the regular spare and 10 points for the bonus).

### Gutter Game

A Gutter Game is when the player never hits a pin (20 zero scores).

### Perfect Game

A Perfect Game is when the player rolls 12 strikes (10 regular strikes and 2 strikes for the bonus in the 10th frame). The Perfect Game scores 300 points.

## My Approach:

- Bowling game score will be input as a single array of integers, each representing the pins knocked down in consecutive throws, exactly as the sequence proceeds in real life (ie a sequence of 1 normal frame, followed by a strike, followed by a spare, followed by a normal frame would read [5,3,10,4,6,3,2])
- Object: Class: CalculateScorecard created to calculate the players' total score from their throw sequence array.
- Object: Class: GameGenerator created to use random throws to simulate a game and create sequence array
- Object: Class: ScorePrinter created to output to terminal the full scorecard and running totals as would be seen by a player in real life
- Object: Class: bowling created as the interface for a command line app that runs/scores the game



