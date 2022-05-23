require 'pry-byebug'
require_relative '../lib/ttt_player'

class Game
  attr_reader :player_one, :player_two, :players, :interface, :backend

  def initialize(player_one = Player.new(ask_name(1), 1, 'x'), player_two = Player.new(ask_name(2), 2, 'o'))
    @player_one = player_one
    @player_two = player_two
    @players = [@player_one, @player_two]
    @interface = create_interface
    @backend = create_backend
  end

  def ask_name(number)
    puts "What is the name of Player #{number}? "
    gets.chomp
  end

  def play_game
    print_interface
    loop do
      @player = @players.shift
      player_turn
      print_interface
      @players.push(@player)
      if winner_col? || winner_row? || winner_diag?
        winner
        break
      elsif draw?
        puts "GAME ENDS IN DRAW!"
        break
      end
    end
        
  end

  def player_turn
    loop do
      board_num = verify_input(player_input)
      next if board_num == false
      # byebug
      index = board_num.to_i - 1
      unless space_taken?(index)
        update_backend(index, @player.number)
        update_interface(index, @player.letter)
        # print_interface
        break
      else
        # print_interface
        puts 'Invalid input! Space already taken!'
      end
      # break unless space_taken?(index)
      # break unless space_taken?(index)
      # puts 'Invalid input!'
    end
  end

  def verify_input(number)
    return number if number.match?(/^[1-9]$/)
    false
  end
  
  def player_input
    puts "#{@player.name}, enter a number that corresponds to the game board: "
    gets.chomp
  end

  def create_interface
    (1..9).to_a
  end

  def create_backend
    Array.new(9,0)
  end

  def print_interface
    puts ''
    row = ''
    row_counter = 0
    @interface.each_index do |idx|
      row.concat(@interface[idx].to_s + ' ')
      row_counter += 1
      if row_counter ==  3
        puts row
        row_counter = 0
        row = ''
      end
    end
  end

  def update_interface(index, letter)
    @interface[index] = letter
  end

  def update_backend(index, number)
    @backend[index] = number
  end

  def space_taken?(index)
    if @backend[index].zero?
      false
    else
      true
    end
  end

  def winner
    puts "#{@player.name} wins the game of tic-tac-toe!"
  end

  def winner_col?
    if @player.number.eql?(@backend[0]) && @player.number.eql?(@backend[3]) && @player.number.eql?(@backend[6])
      true
    elsif @player.number.eql?(@backend[1]) && @player.number.eql?(@backend[4]) && @player.number.eql?(@backend[7])
      true
    elsif @player.number.eql?(@backend[2]) && @player.number.eql?(@backend[5]) && @player.number.eql?(@backend[8])
      true
    else
      false
    end
  end

  def winner_row?
    if @player.number.eql?(@backend[0]) && @player.number.eql?(@backend[1]) && @player.number.eql?(@backend[2])
      true
    elsif @player.number.eql?(@backend[3]) && @player.number.eql?(@backend[4]) && @player.number.eql?(@backend[5])
      true
    elsif @player.number.eql?(@backend[6]) && @player.number.eql?(@backend[7]) && @player.number.eql?(@backend[8])
      true
    else
      false
    end
  end

  def winner_diag?
    if @player.number.eql?(@backend[0]) && @player.number.eql?(@backend[4]) && @player.number.eql?(@backend[8])
      true
    elsif @player.number.eql?(@backend[2]) && @player.number.eql?(@backend[4]) && @player.number.eql?(@backend[6])
      true
    else
      false
    end
  end

  def draw?
    return false if @backend.include?(0)
    true
  end
end