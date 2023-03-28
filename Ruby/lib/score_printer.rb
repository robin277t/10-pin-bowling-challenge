class ScorePrinter
  def initialize(game_array, cumulative_totals)
    @throws = game_array
    @cumulative_totals = cumulative_totals
  end
  
  def get_printout 
    "#{make_header}\n#{stringify_throws} |\n#{stringify_totals} |"
  end

  private

  def make_header
    header = '|'
    round = 1
    10.times do
      header += " --#{round}-- |"
      round += 1
    end
    return header
  end
  
  def stringify_throws
    go = 0
    frame = 1
    throws_string = ""
    10.times do
      if @throws[go] + @throws[go + 1] < 10
        throws_string += "|  #{@throws[go]} #{@throws[go + 1]}  "
      elsif @throws[go] + @throws[go + 1] == 10 && @throws[go] != 10
        throws_string += "|  #{@throws[go]} /  " unless frame == 10
      else
        throws_string += "|  X -  " unless frame == 10
      end
      if frame == 10 && @throws[go] + @throws[go + 1] >= 10
        throws_string = frame_10_symbols(throws_string, go)
      end
      go -= 1 if @throws[go] == 10
      go += 2
      frame += 1
    end 
    throws_string 
  end
  
  def stringify_totals
    totals_string = "|    " + @cumulative_totals.join("  |   ")
  end

  def frame_10_symbols(throws_string, go)
    if @throws[go] + @throws[go + 1] == 10 && @throws[go] != 10
      throws_string += "|  #{@throws[go]} / "
      @throws[go + 2] == 10 ? throws_string += "X" : throws_string += "#{@throws[go + 2]}"
    end
    if @throws[go] == 10
      throws_string += "|  X "
      @throws[go + 1] == 10 ? throws_string += "X " : throws_string += "#{@throws[go + 1]} "
      @throws[go + 1] + @throws[go + 2] == 10 && @throws[go + 1] != 10 ? throws_string += "/" : throws_string += "#{@throws[go + 2]}"
      throws_string[-4,4] = "X X" if throws_string[-4,4] == "X 10" 
    end
    throws_string
  end

end