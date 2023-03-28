class ScorecardCalculator 
  attr_accessor :frames

  def initialize
    @frames = []
  end

  def add_bonus_scores
    @frames.each_with_index do |frame, index| 
      if frame.round == 10
          break
      end
      if frame.go1 + frame.go2 == 10 && frame.go1 < 10
          frame.total = frame.go1 + frame.go2 + @frames[index +1].go1
      elsif frame.go1 == 10 && (@frames[index +1].go1 < 10 || frame.round == 9)
          frame.total = frame.go1 + @frames[index +1].go1 + @frames[index +1].go2
      elsif frame.go1 == 10 && @frames[index +1].go1 == 10 && frame.round < 9
          frame.total = frame.go1 + @frames[index +1].go1 + @frames[index +2].go1
      end
    end
  end

  def generate_printable_scorecard
    header = '|'
    individual_rolls = ''
    cumulative_round_total = 0
    cumulative_round_total_string = ''
    @frames.each_with_index do |frame, index| 
      header += " --#{index + 1}-- |"
      individual_rolls += "|  #{frame.print1} #{frame.print2} #{frame.print3} "
      # individual_rolls += "|  #{frame.go1} #{frame.go2}  " #THESE 2 LINES CAN BE USED INSTEAD OF THE ONE ABOVE IF NO SYMBOLS ARE DESIRED
      # individual_rolls += "#{frame.go3} |" if index == 9 #THESE 2 LINES CAN BE USED INSTEAD OF THE ONE ABOVE IF NO SYMBOLS ARE DESIRED
      cumulative_round_total += frame.total
      cumulative_round_total_string += "|   #{cumulative_round_total}  "
    end 
    "#{header}\n#{individual_rolls}\n#{cumulative_round_total_string}"
  end

end




