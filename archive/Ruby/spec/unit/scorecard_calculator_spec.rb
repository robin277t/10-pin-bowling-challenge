require_relative "../../lib/scorecard_calculator"
require_relative "../../lib/frame"

RSpec.describe "Scorecard calculator unit tests" do

    let(:new_bowl) {ScorecardCalculator.new}
    
    context "add bonus scores function" do
        it "adds spare bonus to round 1 if round 2 not a strike" do
            new_frame1 = Frame.new(1)
            new_frame1.go1 = 8
            new_frame1.go2 = 2
            new_frame2 = Frame.new(2)
            new_frame2.go1 = 5
            new_bowl.frames << new_frame1
            new_bowl.frames << new_frame2
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (15)
        end

        it "adds spare bonus to round 9 if round 10 not a strike" do
            new_frame9 = Frame.new(9)
            new_frame9.go1 = 8
            new_frame9.go2 = 2
            new_frame10 = Frame.new(10)
            new_frame10.go1 = 8
            new_bowl.frames << new_frame9
            new_bowl.frames << new_frame10
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (18)
        end

        it "does not add spare bonus to round 10 spare" do
            new_frame10 = Frame.new(10)
            new_frame10.go1 = 8
            new_frame10.go2 = 2
            new_frame10.go3 = 1
            new_frame10.total = 11
            new_bowl.frames << new_frame10
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (11)
        end

        it "does not add strike bonus to round 10 strike" do
            new_frame10 = Frame.new(10)
            new_frame10.go1 = 10
            new_frame10.go2 = 3
            new_frame10.go3 = 1
            new_frame10.total = 14
            new_bowl.frames << new_frame10
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (14)
        end

        it "adds spare bonus to round 1 if round 2 is a strike" do
            new_frame1 = Frame.new(1)
            new_frame1.go1 = 8
            new_frame1.go2 = 2
            new_frame2 = Frame.new(2)
            new_frame2.go1 = 10
            new_frame3 = Frame.new(3)
            new_frame3.go1 = 1
            new_bowl.frames << new_frame1
            new_bowl.frames << new_frame2
            new_bowl.frames << new_frame3
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (20)
        end

        it "adds spare bonus to round 9 if round 10 is a strike" do
            new_frame9 = Frame.new(9)
            new_frame9.go1 = 8
            new_frame9.go2 = 2
            new_frame10 = Frame.new(10)
            new_frame10.go1 = 10
            new_bowl.frames << new_frame9
            new_bowl.frames << new_frame10
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (20)
        end

        it "adds strike bonus to round 1 if round 2 not a strike" do
            new_frame1 = Frame.new(1)
            new_frame1.go1 = 10
            new_frame2 = Frame.new(2)
            new_frame2.go1 = 6
            new_bowl.frames << new_frame1
            new_bowl.frames << new_frame2
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (16)
        end

        it "adds strike bonus to round 1 if round 2 is a strike" do
            new_frame1 = Frame.new(1)
            new_frame1.go1 = 10
            new_frame2 = Frame.new(2)
            new_frame2.go1 = 10
            new_frame3 = Frame.new(3)
            new_frame3.go1 = 2
            new_bowl.frames << new_frame1
            new_bowl.frames << new_frame2
            new_bowl.frames << new_frame3
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (22)
        end

        it "adds strike bonus to round 9 if round 10 is a strike" do
            new_frame9 = Frame.new(9)
            new_frame9.go1 = 10
            new_frame10 = Frame.new(10)
            new_frame10.go1 = 10
            new_frame10.go2 = 9
            new_frame10.go3 = 0
            new_bowl.frames << new_frame9
            new_bowl.frames << new_frame10
            new_bowl.add_bonus_scores
            expect(new_bowl.frames[0].total).to eq (29)
        end
    end

    context "generate_printable_scorecard function" do
        it "outputs 1 frame header correctly" do
            new_frame1 = Frame.new(1)
            new_bowl.frames << new_frame1
            expect(new_bowl.generate_printable_scorecard).to include("| --1-- |")
        end

        it "outputs 1 frame header + individual rolls correctly" do
            new_frame1 = Frame.new(1)
            new_frame1.print1 = 7
            new_frame1.print2 = 1
            new_frame1.print3 = ''
            new_bowl.frames << new_frame1
            expect(new_bowl.generate_printable_scorecard).to include("| --1-- |")
            expect(new_bowl.generate_printable_scorecard).to include("|  7 1  ")
        end

        it "outputs 1 frame header + individual rolls + cumulative round total correctly" do
            new_frame1 = Frame.new(1)
            new_frame1.print1 = 7
            new_frame1.print2 = 1
            new_frame1.print3 = ''
            new_frame1.total = 8
            new_bowl.frames << new_frame1
            expect(new_bowl.generate_printable_scorecard).to include("| --1-- |")
            expect(new_bowl.generate_printable_scorecard).to include("|  7 1  ")
            expect(new_bowl.generate_printable_scorecard).to include("|   8  ")
        end

        it "outputs 2 frame headera + individual rolls + cumulative round totala correctly" do
            new_frame1 = Frame.new(1)
            new_frame1.print1 = 7
            new_frame1.print2 = 1
            new_frame1.print3 = ''
            new_frame1.total = 8
            new_frame2 = Frame.new(2)
            new_frame2.print1 = 6
            new_frame2.print2 = 3
            new_frame2.print3 = ''
            new_frame2.total = 9
            new_bowl.frames << new_frame1
            new_bowl.frames << new_frame2
            expect(new_bowl.generate_printable_scorecard).to include("| --1-- | --2-- |")
            expect(new_bowl.generate_printable_scorecard).to include("|  7 1  |  6 3  ")
            expect(new_bowl.generate_printable_scorecard).to include("|   8  |   17  ")
        end
    end
end