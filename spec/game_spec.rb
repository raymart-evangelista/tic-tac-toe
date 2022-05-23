require_relative '../lib/ttt_game'
require_relative '../lib/ttt_player'

describe Game do

  let(:one) { double('player_one', name: 'one', number: 1, letter: 'x') }
  let(:two) { double('player_two', name: 'two', number: 2, letter: 'o') }
  subject(:game) { described_class.new(one, two) }

  describe '#initialize' do
    context 'when player is initialized' do
      it 'is a valid player one name' do
        p1 = game.player_one
        expect(p1.name).to match('one')
      end

      it 'is a valid player two name' do
        p2 = game.player_two
        expect(p2.name).to match('two')
      end
    end

  end

  describe '#winner_col?' do
    context 'when player has a full first column' do
      it 'returns true' do
        back = [1,0,0,1,0,0,1,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_col 
        game.winner_col?
      end
    end

    context 'when player has a full second column' do
      it 'returns true' do
        back = [0,1,0,0,1,0,0,1,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)
        game.winner_col?
      end
    end

    context 'when player has a full third column' do
      it 'returns true' do
        back = [0,0,1,0,0,1,0,0,1]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)
        game.winner_col?
      end
    end

    context 'when player doesnt have a full column' do
      it 'returns false' do
        game.instance_variable_set(:@player, one)
        expect(game).to_not be_winner_col
        game.winner_col?
      end
    end
  end

  describe '#winner_row?' do
    context 'when player has a full first row' do
      it 'returns true' do
        back = [1,1,1,0,0,0,0,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_row
        game.winner_row?
      end
    end
    
    context 'when player has a full first row' do
      it 'returns true' do
        back = [0,0,0,1,1,1,0,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_row
        game.winner_row?
      end
    end

    context 'when player has a full third row' do
      it 'returns true' do
        back = [0,0,0,0,0,0,1,1,1]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_row
        game.winner_row?
      end
    end

    context 'when player doesnt have a full row' do
      it 'returns false' do
        back = [0,0,0,0,0,0,0,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to_not be_winner_row
        game.winner_row?
      end
    end
  end

  describe '#winner_diag?' do
    context 'when a player has a full diagonal from top left to bottom right' do
      it 'returns true' do
        back = [1,0,0,0,1,0,0,0,1]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_diag
        game.winner_diag?
      end
    end

    context 'when a player has a full diagonal from top right to bottom left' do
      it 'returns true' do
        back = [0,0,1,0,1,0,1,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to be_winner_diag
        game.winner_diag?
      end
    end

    context 'when a player has no full diagonal' do
      it 'returns false' do
        back = [0,0,0,0,0,0,0,0,0]
        game.instance_variable_set(:@player, one)
        game.instance_variable_set(:@backend, back)

        expect(game).to_not be_winner_diag
        game.winner_diag?
      end
    end
  end

  describe '#draw?' do
    context 'when the entire tic-tac-toe board is complete' do
      it 'returns true' do
        back = [1,2,1,1,2,2,2,1,2]
        game.instance_variable_set(:@backend, back)

        expect(game).to be_draw
        game.draw?
      end
    end
  end

  describe '#player_turn' do
    context 'when user input is valid' do
      it 'stops loop and does not display invalid input message' do
        game.instance_variable_set(:@player, one)
        valid_input = '1'
        allow(game).to receive(:player_input).and_return(valid_input)
        expect(game).not_to receive(:puts).with('Invalid input! Space already taken!')
        game.player_turn
      end
    end

    context 'when user input is invalid once because number out of range, then valid' do
      before do
        game.instance_variable_set(:@player, one)
        back = [0,0,0,0,0,0,0,0,0]
        game.instance_variable_set(:@backend, back)
        invalid_input = '33'
        valid_input = '1'
        # allow(game).to receive(:player_input).and_return(invalid_input, valid_input)
        allow(game).to receive(:verify_input).and_return(invalid_input, valid_input)
        allow(game).to receive(:space_taken?).and_return(false)
      end

      it 'completes loop without any invalid input message' do
        expect(game).to receive(:puts).with("#{one.name}, enter a number that corresponds to the game board: ").once
        game.player_turn
      end
    end

    context 'when user input is invalid once because space taken, then valid' do
      before do
        game.instance_variable_set(:@player, one)
        back = [1,0,0,0,0,0,0,0,0]
        game.instance_variable_set(:@backend, back)
        invalid_input = '1'
        valid_input = '2'
        allow(game).to receive(:player_input).and_return(invalid_input, valid_input)
        # allow(game).to receive(:verify_input).and_return(invalid_input, valid_input)
        # allow(game).to receive(:space_taken?).and_return(true)
      end

      it 'completes loop and displays invalid input message once' do
        expect(game).to receive(:puts).with('Invalid input! Space already taken!').once
        game.player_turn
      end
    end
  end

  describe '#update_interface' do
    it 'returns letter that updates interface value' do
      interface = [1, 2, 3, 4, 5, 6, 7, 8]
      game.instance_variable_set(:@interface, interface)
      index = 0
      letter = 'x'

      expect(game.update_interface(index,letter)).to eq('x')
      # game.update_interface(index, letter)
    end
  end

  describe '#update_backend' do
    it 'returns number that updates backend value' do
      back = [0, 0, 0, 0, 0, 0, 0, 0, 0]
      game.instance_variable_set(:@back, back)
      index = 0
      number = 1

      expect(game.update_backend(index, number)).to eq(1)
    end
  end

  describe '#space_taken?' do
    context 'when backend index is not taken' do
      it 'returns false' do
        back = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        game.instance_variable_set(:@backend, back)
        index = 0
        expect(game.space_taken?(index)).to eq(false)
      end
    end

    context 'when backend index is taken' do
      it 'returns true' do
        back = [1, 0, 0, 0, 0, 0, 0, 0, 0]
        game.instance_variable_set(:@backend, back)
        index = 0
        expect(game.space_taken?(index)).to eq(true)
      end
    end
  end

  describe '#play_game' do
    context 'when player has a whole first column' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [1, 0, 0, 1, 0, 0, 1, 0, 0]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a whole second column' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [0, 1, 0, 0, 1, 0, 0, 1, 0]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a whole third column' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [0, 0, 1, 0, 0, 1, 0, 0, 1]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a whole first row' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [1, 1, 1, 0, 0, 0, 0, 0, 0]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a whole second row' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [0, 0, 0, 1, 1, 1, 0, 0, 0]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a whole third row' do      before do
      allow(game).to receive(:print_interface)
      game.instance_variable_set(:@player, one)
      back = [0, 0, 0, 0, 0, 0, 1, 1, 1]
      game.instance_variable_set(:@backend, back)
      allow(game).to receive(:player_turn)
    end
    
    it 'puts winner of the game' do
      expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
      game.play_game
    end
    end

    context 'when player has a top left to bottom right diagonal' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [1, 0, 0, 0, 1, 0, 0, 0, 1]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when player has a bottom left to top right diagonal' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [0, 0, 1, 0, 1, 0, 1, 0, 0]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end
      
      it 'puts winner of the game' do
        expect(game).to receive(:puts).with("#{one.name} wins the game of tic-tac-toe!").once
        game.play_game
      end
    end

    context 'when there is no winner' do
      before do
        allow(game).to receive(:print_interface)
        game.instance_variable_set(:@player, one)
        back = [1,2,1,1,2,2,2,1,2]
        game.instance_variable_set(:@backend, back)
        allow(game).to receive(:player_turn)
      end

      it 'puts draw message' do
        expect(game).to receive(:puts).with("GAME ENDS IN DRAW!").once
        game.play_game
      end
    end
  end
end