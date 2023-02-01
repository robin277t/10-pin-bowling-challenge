require_relative "./lib/scorecard_calculator"
require_relative "./lib/frame"
require_relative "./lib/input"

class GameRunner
  def initialize
    @game_scorecard = ScorecardCalculator.new
  end
    
  def run_game
    input = Input.new
    round = 1
    while round <= 10
      new_frame = Frame.new(round)
      new_frame.create_frame_scores
      new_frame.add_symbols # THIS METHOD CAN BE OMITTED IF SYMBOLS OUTPUT NOT DESIRED
      @game_scorecard.frames << new_frame
      round +=1
    end
    @game_scorecard.add_bonus_scores
    output = @game_scorecard.generate_printable_scorecard
    puts output
    return output
  end


end

new_game = GameRunner.new
new_game.run_game