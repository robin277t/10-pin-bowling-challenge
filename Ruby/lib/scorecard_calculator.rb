class ScorecardCalculator

  def initialize(throws_array)
    @throws = throws_array
    @cumulative_totals = []
    calculate_total
  end

  def get_game_total
    @cumulative_totals[-1]
  end

  def get_cumulative_totals
    @cumulative_totals
  end

  private

  def calculate_total
    go = 0
    running_total = 0
    10.times do
      if @throws[go] + @throws[go + 1] < 10
        running_total += (@throws[go] + @throws[go + 1])
      else
        running_total += (@throws[go] + @throws[go + 1] + @throws[go + 2])
      end
      go -= 1 if @throws[go] == 10
      go += 2
      @cumulative_totals << running_total
    end
  end
  
end