require_relative "../lib/game_generator"

RSpec.describe "Unit test Block 2:" do

  let(:new_game) {GameGenerator.new}

  context "Full game creation" do
    it "Creates array" do
      expect(new_game.get_game).to be_a(Array)
    end
    it "array is added to" do
      expect(new_game.get_game.length).to be >0
    end
    it "whole game minimum 11 throws is added" do
      expect(new_game.get_game.length).to be >10
    end
    it "fills each array with random numbers between 0 and 10" do
      new_game.get_game.each do |throw|
        expect(throw).to be_between(0,10).inclusive
      end
    end
    it "calls bonify_frame10 if the last two throws sum to 10 or more" do
      allow(new_game).to receive(:generate_random_rolls).and_return(5)
      new_game.instance_variable_set(:@game_array, [0] * 18 + [5, 5])
      expect(new_game).to receive(:bonify_frame_10).once
      new_game.send(:create_game_array)
    end
    it "makes sure bonify frame 10 is called if frame 10 starts with spare" do
      allow(new_game).to receive(:generate_random_rolls).and_return(10)
      new_game.instance_variable_set(:@game_array, [10] * 10 + [10, 10])
      expect(new_game).to receive(:bonify_frame_10).once
      new_game.send(:create_game_array)
    end
    it "makes sure bonify frame 10 is NOT called if frame 10 is normal" do
      allow(new_game).to receive(:generate_random_rolls).and_return(4)
      new_game.instance_variable_set(:@game_array, [0] * 18 + [4, 4])
      expect(new_game).not_to receive(:bonify_frame_10)
    end
    
  end

end