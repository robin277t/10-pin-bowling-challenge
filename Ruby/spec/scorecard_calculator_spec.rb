require_relative "../lib/scorecard_calculator"

RSpec.describe "UNIT test block 1: scorecard_calculator class" do

  context "A: normal frames" do 
    it "1: normal frame scores correctly first" do
      throws = [2,3,4,5,0,2,4,4,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.getTotal).to eq (63)
    end
    it "2: normal frame scores correctly second" do
      throws = [2,3,4,5,0,2,1,1,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.getTotal).to eq (57)
    end
  end
end

#test normal frames
#test spare frames
#test strike frames
#test normal frame 10
#test spare + normal frame 10
#test strike + 2x normals frame 10
#test 2x strikes + 1 normal frame 10
#test spare + strike frame 10
#test 3x strikes frame 10
#test gutter game
#test non-numerical input arrays
#test too many or too few numbers in input array