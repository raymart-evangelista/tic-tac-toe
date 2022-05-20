# Player class is a blueprint to keep track of each player's information
class Player
  attr_reader :name, :number, :letter

  def initialize(name, number, letter)
    @name = name
    @number = number
    @letter = letter
    puts "Player #{@name} created with backend number: #{@number} and interface letter: #{@letter}"
    puts ''
  end
end

def ask_name(number)
  puts "What is the name of Player #{number}? "

  gets.chomp
end