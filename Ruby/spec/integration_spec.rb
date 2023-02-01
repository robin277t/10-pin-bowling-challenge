require_relative "../lib/frame"
require_relative "../lib/input"
require_relative "../lib/scorecard_calculator"
require_relative "../app"

describe "bowling unit tests" do

    let(:new_frame1) {Frame.new(1)}
    let(:new_bowl) {ScorecardCalculator.new} 
    let(:rolls) {Input.new}
    let(:run) {GameRunner.new}

    it "Frame class initializes correctly" do
        expect(new_frame1.total).to eq (0)
        expect(new_frame1.print2).to eq ('-')
    end

    it "Bowling class frames array" do
        expect(new_bowl.frames).to eq ([])
    end

    it "Run Game loop adds 10 frames" do
        expect(run.run_game).to include("--10--")
    end

    it "Gutter game works" do
        allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(0)
        expect(run.run_game).to include("|  0 0  |  0 0  |  0 0  |  0 0  |  0 0  |  0 0  |  0 0  |  0 0  |  0 0  |  0 0  ")
    end
    
    it "Perfect game works" do
        allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(10)
        expect(run.run_game).to include("300")
    end
    
    it "Always 4 game score works" do
        allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(4)
        expect(run.run_game).to include("72  |   80")
    end

    it "Always 5 game score works" do
        allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(5)
        expect(run.run_game).to include("135  |   150")
    end

end


        # it "getScores inputs a round 10 strike cases correctly" do
        #     mockRolls = double (:rollframes)
        #     allow(mockRolls).to receive(:generateScores).with(10).and_return(10)
        #     newBowl.getScores(newFrame,10, mockRolls)
        #     puts 
        #     expect(newBowl.frames[0].go1).to eq (10)
        #     expect(newBowl.frames[0].go2).to eq (10)
        #     expect(newBowl.frames[0].go3).to eq (10)
        # end

        # it "getScores inputs a round 10 half strike case correctly" do
        #     mockRolls = double (:rollframes)
        #     allow(mockRolls).to receive(:generateScores).with(anything).and_return(5)
        #     newBowl.getScores(newFrame,10, mockRolls)
        #     expect(newBowl.frames[0].go1).to eq (5)
        #     expect(newBowl.frames[0].go2).to eq (5)
        #     expect(newBowl.frames[0].go3).to eq (5)
        # end