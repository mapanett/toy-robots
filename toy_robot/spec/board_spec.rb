# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new(5) }

  describe 'valid_position' do
    it 'returns true for valid positions' do
      expect(board.valid_position(Position.new(0, 0))).to be_truthy
      expect(board.valid_position(Position.new(4, 4))).to be_truthy
    end

    it 'returns false for invalid positions' do
      expect(board.valid_position(Position.new(-1, 0))).to be_falsey
      expect(board.valid_position(Position.new(4, 5))).to be_falsey
    end
  end
end
