  # def generate_printable_scorecard
  #   header = '|'
  #   individual_rolls = ''
  #   cumulative_round_total = 0
  #   cumulative_round_total_string = ''
  #   @frames.each_with_index do |frame, index| 
  #     header += " --#{index + 1}-- |"
  #     individual_rolls += "|  #{frame.print1} #{frame.print2} #{frame.print3} "
  #     # individual_rolls += "|  #{frame.go1} #{frame.go2}  " #THESE 2 LINES CAN BE USED INSTEAD OF THE ONE ABOVE IF NO SYMBOLS ARE DESIRED
  #     # individual_rolls += "#{frame.go3} |" if index == 9 #THESE 2 LINES CAN BE USED INSTEAD OF THE ONE ABOVE IF NO SYMBOLS ARE DESIRED
  #     cumulative_round_total += frame.total
  #     cumulative_round_total_string += "|   #{cumulative_round_total}  "
  #   end 
  #   "#{header}\n#{individual_rolls}\n#{cumulative_round_total_string}"
  # end



  # def add_symbols 
  #   @print1 = @go1
  #   if @go1 + @go2 < 10
  #       @print2 = @go2
  #   elsif @go1 == 10
  #       @print1 = 'X'
  #   elsif @go1 + @go2 == 10 && @go1 < 10
  #       @print2 = '/'
  #   end
  #   case @round when (10) 
  #     if @print2 == '/' && @go3 < 10
  #       @print3 = @go3
  #     elsif @print2 == '/' && @go3 == 10
  #       @print3 = 'X'
  #     elsif @print1 == 'X' && @go2 + @go3 < 10
  #       @print2 = @go2
  #       @print3 = @go3
  #     elsif @print1 == 'X' && @go2 < 10 && @go2 + @go3 == 10
  #       @print2 = @go2
  #       @print3 = '/'
  #     elsif @print1 == 'X' && @go2 == 10 && @go3 < 10
  #       @print2 = 'X'
  #       @print3 = @go3
  #     elsif @print1 == 'X' && @go2 == 10 && @go3 == 10
  #       @print2 = 'X'
  #       @print3 = 'X'
  #     end
  #   end
  # end