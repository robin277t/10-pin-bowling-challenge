require_relative "../lib/score_printer"

RSpec.describe "Unit test Block3: ScorePrinter class" do
  it "returns header for terminal print out" do
    game_array = Array.new(20) {4}
    printer = ScorePrinter.new(game_array, [8,16,24,32,40,48,56,64,72,80])
    expect(printer.get_printout).to include("| --3-- |")
  end
  it "returns normal throw scores for terminal print out" do
    game_array = Array.new(20) {4}
    printer = ScorePrinter.new(game_array, [8,16,24,32,40,48,56,64,72,80])
    expect(printer.get_printout).to include("|  4 4  |")
  end
  it "returns normal frame total scores for terminal print out" do
    game_array = Array.new(20) {4}
    printer = ScorePrinter.new(game_array, [8,16,24,32,40,48,56,64,72,80])
    expect(printer.get_printout).to include("|   16  |   24  |")
  end

  it "returns spare frame symbol for terminal print out" do
    printer = ScorePrinter.new([9,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [15,20,20,20,20,20,20,20,20,20])
    expect(printer.get_printout).to include("|  9 /  |  5 0  |")
  end

  it "returns strike frame symbol for terminal print out" do
    printer = ScorePrinter.new([9,1,10,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [20,35,35,35,35,35,35,35,35,35])
    expect(printer.get_printout).to include("|  9 /  |  X -  |")
  end

  it "returns strike frame symbol fon frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,3,3], [0,0,0,0,0,0,0,0,0,16])
    expect(printer.get_printout).to include("|  0 0  |  X 3 3")
  end

  it "returns strike frame symbol for 2 strikes frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,3], [0,0,0,0,0,0,0,0,0,23])
    expect(printer.get_printout).to include("|  0 0  |  X X 3")
  end

  it "returns strike frame symbol for 3 strikes frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10], [0,0,0,0,0,0,0,0,0,30])
    expect(printer.get_printout).to include("|  0 0  |  X X X")
  end

  it "returns strike frame symbol plus spare frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,3,7], [0,0,0,0,0,0,0,0,0,20])
    expect(printer.get_printout).to include("|  0 0  |  X 3 /")
  end

  it "returns spare frame symbol plus normal frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,3], [0,0,0,0,0,0,0,0,0,13])
    expect(printer.get_printout).to include("|  0 0  |  5 / 3")
  end

  it "returns spare frame symbol plus strike frame 10 terminal print out" do
    printer = ScorePrinter.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,10], [0,0,0,0,0,0,0,0,0,20])
    expect(printer.get_printout).to include("|  0 0  |  5 / X")
  end
  
end