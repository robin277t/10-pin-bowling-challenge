require_relative "./lib/scorecard_calculator"
require_relative "./lib/game_generator"
require_relative "./lib/score_printer"

class Bowling
  def initialize(
    score_calc_class: ScorecardCalculator, 
    game_gen_class: GameGenerator, 
    print_class: ScorePrinter
  )
    @score_calc_class = score_calc_class
    @game_gen_class = game_gen_class
    @print_class = print_class
  end

  def run_game
    new_throws = @game_gen_class.new.get_game
    new_calcs = @score_calc_class.new(new_throws)
    puts "This game scored a total of: #{new_calcs.get_game_total}"
    puts @print_class.new(new_throws, new_calcs.get_cumulative_totals).get_printout
  end

end

Bowling.new.run_game