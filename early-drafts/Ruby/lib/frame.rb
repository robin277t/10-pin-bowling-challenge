require_relative "./input"

class Frame
  attr_accessor :go1, :go2, :go3, :total, :print1, :print2, :print3, :round

  #A lot of this can be simplified with new version embodying encapsulation

  def initialize(round)
    @go1, @go2, @go3, @total, @print1 = 0,0,0,0,0
    @print2 = '-'
    @print3 = ''
    @round = round
  end
  
  def create_frame_scores
    input = Input.new.method(:generate_random_rolls)
    # Alteration to Input class and method can be made if random generator not desired
    @go1 = input.call(10)
    @go2 = input.call(10 - @go1) if @go1 != 10
    if @round == 10 && @go1 == 10
      @go2 = input.call(10)
      @go2 == 10 ? @go3 = input.call(10) : @go3 = input.call(@go2)
    elsif @round == 10 && @go1 + @go2 == 10 
      @go3 = input.call(10)
    end
    @total = @go1 + @go2 + @go3
  end

  #BELOW METHOD IS OPTIONAL, USED FOR FORMATTING SCORECARD OUTPUT WITH SYMBOLS
  def add_symbols 
    @print1 = @go1
    if @go1 + @go2 < 10
        @print2 = @go2
    elsif @go1 == 10
        @print1 = 'X'
    elsif @go1 + @go2 == 10 && @go1 < 10
        @print2 = '/'
    end
    case @round when (10) 
      if @print2 == '/' && @go3 < 10
        @print3 = @go3
      elsif @print2 == '/' && @go3 == 10
        @print3 = 'X'
      elsif @print1 == 'X' && @go2 + @go3 < 10
        @print2 = @go2
        @print3 = @go3
      elsif @print1 == 'X' && @go2 < 10 && @go2 + @go3 == 10
        @print2 = @go2
        @print3 = '/'
      elsif @print1 == 'X' && @go2 == 10 && @go3 < 10
        @print2 = 'X'
        @print3 = @go3
      elsif @print1 == 'X' && @go2 == 10 && @go3 == 10
        @print2 = 'X'
        @print3 = 'X'
      end
    end
  end

end