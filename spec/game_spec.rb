require_relative '../lib/ttt_game'
require_relative '../lib/ttt_player'

describe Game do

  subject(:game) { described_class.new }
  let(:one) { double('player_one', name: 'one', number: 1, letter: 'x') }
  let(:two) { double('player_two', name: 'two', number: 2, letter: 'o') }

  describe '#initialize' do
    # test #print_interface method call,
    # it is a script method that doesn't return anything.
    # it prints out the rows
  end

  describe '#create_interface' do

  end

  describe '#create_backend' do
  end

  describe '#print_interface' do
  end

  describe '#update_interface' do
  end

  describe '#update_backend' do
  end

  describe '#winner?' do

    context 'when column_wise, row_wise, diagonal_wise are all false' do
      before do
        allow(game).to receive(:winner_column_wise?).and_return(false)
        allow(game).to receive(:winner_row_wise?).and_return(false)
        allow(game).to receive(:winner_diagonal_wise?).and_return(false)
      end

      it 'returns false' do
        expect(game.winner?(one)).to eq(false)
      end
    end

    context 'when column_wise and row_wise are false, and diagonal_wise is true' do
      before do
        allow(game).to receive(:winner_column_wise?).and_return(false)
        allow(game).to receive(:winner_row_wise?).and_return(false)
        allow(game).to receive(:winner_diagonal_wise?).and_return(true)
      end

      it 'returns true' do
        expect(game.winner?(one)).to eq(true)
      end
    end

    context 'when column_wise and diagonal_wise are false, and row_wise is true' do
      before do
        allow(game).to receive(:winner_column_wise?).and_return(false)
        allow(game).to receive(:winner_row_wise?).and_return(true)
        allow(game).to receive(:winner_diagonal_wise?).and_return(false)
      end

      it 'returns true' do
        expect(game.winner?(one)).to eq(true)
      end
    end

    context 'when diagonal_wise and row_wise are false, and column_wise is true' do
      before do
        allow(game).to receive(:winner_column_wise?).and_return(true)
        allow(game).to receive(:winner_row_wise?).and_return(false)
        allow(game).to receive(:winner_diagonal_wise?).and_return(false)
      end

      it 'returns true' do
        expect(game.winner?(one)).to eq(true)
      end
    end
  end

  describe '#winner_column_wise?' do
    context 'when first column are all true' do

      backend = Array.new(9,0)
      backend[0] = 1
      backend[3] = 1
      backend[6] = 1

      it 'returns true' do
        # expect(game.winner_column_wise?(one)).to return(true)
      end
      
      xit 'returns true when player takes second column' do
      end

      xit 'returns true when player takes third column' do
      end
    end
  end

  describe '#winner_row_wise?' do
  end

  describe '#winner_diagonal_wise?' do
  end

  describe '#space_taken?' do
  end

  describe '#draw?' do
  end

  describe '#ask_input' do
  end

  describe '#winner' do
  end

  
end