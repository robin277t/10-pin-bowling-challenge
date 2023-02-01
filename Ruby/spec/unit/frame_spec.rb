require_relative "../../lib/frame"
require_relative "../../lib/input"


RSpec.describe "frame class" do
    
    let(:new_frame1) {Frame.new(1)}
    let(:new_frame10) {Frame.new(10)}
    
    context "create_frame_scores method"  do
        it "updates a new Frame round 1 with first and second rolls of 5 " do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(5)
            new_frame1.create_frame_scores
            expect(new_frame1.go1).to eq (5)
            expect(new_frame1.go2).to eq (5)
            expect(new_frame1.go3).to eq (0)
        end

        it "updates a new Frame round 1 with first roll of 10" do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(10)
            new_frame1.create_frame_scores
            expect(new_frame1.go1).to eq (10)
            expect(new_frame1.go2).to eq (0)
            expect(new_frame1.go3).to eq (0)
        end

        it "updates a new Frame round 10 with first and second rolls of 4 " do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(4)
            new_frame10.create_frame_scores
            expect(new_frame10.go1).to eq (4)
            expect(new_frame10.go2).to eq (4)
            expect(new_frame10.go3).to eq (0)
        end

        it "updates a new Frame round 10 with first and second rolls of 5" do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(5)
            new_frame10.create_frame_scores
            expect(new_frame10.go1).to eq (5)
            expect(new_frame10.go2).to eq (5)
            expect(new_frame10.go3).to eq (5)
        end

        it "updates a new Frame round 10 with first and second rolls of 10" do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(10)
            new_frame10.create_frame_scores
            expect(new_frame10.go1).to eq (10)
            expect(new_frame10.go2).to eq (10)
            expect(new_frame10.go3).to eq (10)
        end

        it "updates total of frame on normal round" do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(5)
            new_frame1.create_frame_scores
            expect(new_frame1.go1).to eq (5)
            expect(new_frame1.go2).to eq (5)
            expect(new_frame1.go3).to eq (0)
            expect(new_frame1.total).to eq (10)
        end

        it "updates total of frame on 10th round" do
            allow_any_instance_of(Input).to receive(:generate_random_rolls).with(anything).and_return(5)
            new_frame10.create_frame_scores
            expect(new_frame10.go1).to eq (5)
            expect(new_frame10.go2).to eq (5)
            expect(new_frame10.go3).to eq (5)
            expect(new_frame10.total).to eq (15)
        end
    end

    context "add_symbols" do
        it "print1 and print2 on normal frame round 1-9" do
            new_frame1.go1 = 8
            new_frame1.go2 = 1
            new_frame1.add_symbols
            expect(new_frame1.print1).to eq(8)
            expect(new_frame1.print2).to eq(1)
        end

        it "print1 and print2 on spare frame round 1-9" do
            new_frame1.go1 = 7
            new_frame1.go2 = 3
            new_frame1.add_symbols
            expect(new_frame1.print1).to eq(7)
            expect(new_frame1.print2).to eq('/')
        end

        it "print1 and print2 on Strike frame round 1-9" do
            new_frame1.go1 = 10
            new_frame1.add_symbols
            expect(new_frame1.print1).to eq('X')
            expect(new_frame1.print2).to eq('-')
        end

        it "print1 and print2 on normal frame round 10" do
            new_frame10.go1 = 4
            new_frame10.go2 = 3
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq(4)
            expect(new_frame10.print2).to eq(3)
            expect(new_frame10.print3).to eq('')
        end

        it "print1 and print2 on spare frame round 10" do
            new_frame10.go1 = 7
            new_frame10.go2 = 3
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq(7)
            expect(new_frame10.print2).to eq('/')
            expect(new_frame10.print3).to eq(0)
        end

        it "print3 on spare frame round 10 + non-strike" do
            new_frame10.go1 = 7
            new_frame10.go2 = 3
            new_frame10.go3 = 5
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq(7)
            expect(new_frame10.print2).to eq('/')
            expect(new_frame10.print3).to eq(5)
        end

        it "print3 on spare frame round 10 + strike" do
            new_frame10.go1 = 7
            new_frame10.go2 = 3
            new_frame10.go3 = 10
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq(7)
            expect(new_frame10.print2).to eq('/')
            expect(new_frame10.print3).to eq('X')
        end

        it "print1, print2 & print3 on strike frame round 10 plus 2 normals" do
            new_frame10.go1 = 10
            new_frame10.go2 = 3
            new_frame10.go3 = 3
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq('X')
            expect(new_frame10.print2).to eq(3)
            expect(new_frame10.print3).to eq(3)
        end

        it "print1, print2 & print3 on strike frame round 10 plus spare" do
            new_frame10.go1 = 10
            new_frame10.go2 = 3
            new_frame10.go3 = 7
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq('X')
            expect(new_frame10.print2).to eq(3)
            expect(new_frame10.print3).to eq('/')
        end

        it "print1, print2 & print3 on strike frame round 10 plus spare" do
            new_frame10.go1 = 10
            new_frame10.go2 = 0
            new_frame10.go3 = 10
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq('X')
            expect(new_frame10.print2).to eq(0)
            expect(new_frame10.print3).to eq('/')
        end

        it "print1, print2 & print3 on strike frame round 10 plus strike plus normal" do
            new_frame10.go1 = 10
            new_frame10.go2 = 10
            new_frame10.go3 = 7
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq('X')
            expect(new_frame10.print2).to eq('X')
            expect(new_frame10.print3).to eq(7)
        end

        it "print1, print2 & print3 on 3x strikes round 10" do
            new_frame10.go1 = 10
            new_frame10.go2 = 10
            new_frame10.go3 = 10
            new_frame10.add_symbols
            expect(new_frame10.print1).to eq('X')
            expect(new_frame10.print2).to eq('X')
            expect(new_frame10.print3).to eq('X')
        end
    end
end