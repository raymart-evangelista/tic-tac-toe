# Game class is a blueprint for a game of tic tac toe
class Game
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @interface = create_interface
    print_interface
    @backend = create_backend
    # p @backend
  end

  def create_interface
    (1..9).to_a
  end

  def create_backend
    Array.new(9, 0)
  end

  def print_interface
    puts ''
    row = ''
    row_counter = 0
    @interface.each_index do |idx|
      row.concat(@interface[idx].to_s + ' ')
      row_counter += 1
      if row_counter == 3
        puts row
        row_counter = 0
        row = ''
      end
    end
  end

  def update_interface(index, letter)
    @interface[index] = letter
    print_interface
  end

  def update_backend(index, number)
    @backend[index] = number
    # p @backend
  end

  def winner?(player)
    winner_column_wise?(player) || winner_row_wise?(player) || winner_diagonal_wise?(player)
  end

  def winner_column_wise?(player)
    if @backend[0] == player.number && @backend[3] == player.number && @backend[6] == player.number
      return true
    elsif @backend[1] == player.number && @backend[4] == player.number && @backend[7] == player.number
      return true
    elsif @backend[2] == player.number && @backend[7] == player.number && @backend[8] == player.number
      return true
    else
      return false
    end
  end

  def winner_row_wise?(player)
    if @backend[0] == player.number && @backend[1] == player.number && @backend[2] == player.number
      return true
    elsif @backend[3] == player.number && @backend[4] == player.number && @backend[5] == player.number
      return true
    elsif @backend[6] == player.number && @backend[7] == player.number && @backend[8] == player.number
      return true
    else
      return false
    end
  end

  def winner_diagonal_wise?(player)
    if @backend[0] == player.number && @backend[4] == player.number && @backend[8] == player.number
      return true
    elsif @backend[2] == player.number && @backend[4] == player.number && @backend[6] == player.number
      return true
    else
      return false
    end
  end

  def space_taken?(index)
    # if the value at the given index == 0, the space is not taken yet
    if @backend[index].zero?
      false
    else
      true
    end
  end

  def draw?
    return false if @backend.include?(0)

    true
  end

  def ask_input(player)
    # keep asking for a valid index while the index given is taken
    valid_input = false
    until valid_input == true
      puts "#{player.name}, enter a number that corresponds to the game board: "
      begin
        number = Integer(gets.chomp)
        index = number - 1
        valid_input = space_taken?(index) == false
      rescue ArgumentError
        puts "Invalid input!"
        puts ""
      end
    end
    # once we have valid input, update the backend board
    update_backend(index, player.number)
    update_interface(index, player.letter)
  end

  def winner(player)
    puts "#{player.name} wins the game of tic-tac-toe!"
  end
end