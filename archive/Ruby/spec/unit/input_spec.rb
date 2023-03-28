require_relative "../../lib/input"
    
RSpec.describe "Input class unit tests" do

    let(:input) {Input.new}

    context "generate random rolls method" do

        it "generates random number between 0 and 10" do
            expect(input.generate_random_rolls(10)).to be_between(0,10)
        end

        it "generate random number between 0 and 3" do
            expect(input.generate_random_rolls(3)).to be_between(0,3)
        end
    end
    
end


