class GameGenerator 

  def initialize
    @game_array = []
  end

  def get_game
    create_game_array 
    @game_array
  end

  private

  def generate_random_rolls(ceil)
    rand (0..ceil)
  end

  def create_game_array
    10.times do
      throw1 = generate_random_rolls(10)
      @game_array.push(throw1)
      @game_array.push(generate_random_rolls(10- throw1)) if throw1 < 10
    end
    if @game_array[-1] + @game_array[-2] >= 10
      bonify_frame_10
    end
    return @game_array
  end

  def bonify_frame_10
    bonus_throw_1 = generate_random_rolls(10)
    @game_array.push(bonus_throw_1)
    if @game_array[-2] == 10 && @game_array[-3] != 0
      bonus_throw_1 == 10 ? 
      @game_array.push(generate_random_rolls(10)) : 
      @game_array.push(generate_random_rolls(10 - bonus_throw_1))
    end
  end

end