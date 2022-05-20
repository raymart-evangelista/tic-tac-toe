require_relative '../lib/ttt_game'
require_relative '../lib/ttt_player'

# get player info
player_one = Player.new(ask_name(1), 1, 'x')
player_two = Player.new(ask_name(2), 2, 'o')

# store player objects in array
players = [player_one, player_two]

# start a new game with players
game = Game.new(player_one, player_two)

# start game
game_finished = false
until game_finished
  current_player = players.shift
  game.ask_input(current_player)
  players.push(current_player)
  game_finished = game.winner?(current_player)
  if game.winner?(current_player)
    game_finished = true
    game.winner(current_player)
  elsif game.draw?
    game_finished = true
    puts 'DRAW'
  end
end
