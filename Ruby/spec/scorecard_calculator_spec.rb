require_relative "../lib/scorecard_calculator"

RSpec.describe "Unit test block 1: ScorecardCalculator class" do

  context "A: normal frames" do 
    it "1: normal frame scores correctly first" do
      throws = [2,3,4,5,0,2,4,4,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (63)
    end
    it "2: normal frame scores correctly second" do
      throws = [2,3,4,5,0,2,1,1,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (57)
    end
  end
  
  context "B: Spare frames" do 
    it "3: spare frames score correctly first" do
      throws = [7,3,4,5,0,2,4,4,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (72)
    end
    it "4: spare frames score correctly second" do
      throws = [7,3,4,5,0,2,4,6,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (77)
    end
  end

  context "C: Strike frames" do 
    it "5: 1 spare frame and 1 strike frame score correctly" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (80)
    end
    it "6: 1 spare frame and 2 strike frames back to back score correctly" do
      throws = [7,3,4,5,10,10,3,3,6,2,3,0,8,1,9,0,2,2]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (101)
    end
  end

  context "D: 10th frame" do 
    it "7: spare + normal frame 10" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,8,2,4]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (90)
    end
    it "8: strike + 2x normal frame 10" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,10,2,4]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (92)
    end
    it "9: 2x strikes + normal frame 10" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,10,10,4]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (100)
    end
    it "10: 3x strikes frame 10" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,10,10,10]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (106)
    end
  end
  context "E: Edge cases" do
    it "11: gutter game" do
      throws = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (0)
    end
    it "12: perfect game" do
      throws = [10,10,10,10,10,10,10,10,10,10,10,10]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_game_total).to eq (300)
    end
    it "14: get_cumulative_totals works" do
      throws = [7,3,4,5,0,2,10,3,3,6,2,3,0,8,1,9,0,10,10,10]
      scorer = ScorecardCalculator.new(throws)
      expect(scorer.get_cumulative_totals[4]).to eq(47)
    end
  end

end
