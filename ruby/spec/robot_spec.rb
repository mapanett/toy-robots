# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/robot'

RSpec.describe Robot do
  let(:string_writer) { StringIO.new }
  let(:board) { Board.new(5) }
  let(:robot) { Robot.new(board, string_writer) }

  it 'starts off unplaced' do
    expect(robot.position).to be_nil
  end

  describe 'place' do
    it 'can be placed' do
      position = Position.new(1, 1)
      expect(robot.place(position, :next).position).to eq(position)
    end

    it 'cannot be placed on an invalid position' do
      expect(robot.place(Position.new(1, 6), :next).position).to eq(nil)
    end
  end

  describe 'left' do
    it 'can turn left' do
      robot.place(Position.new(1, 1), :north)
      expect(robot.left.direction).to be(:west)
      expect(robot.left.direction).to be(:south)
      expect(robot.left.direction).to be(:east)
      expect(robot.left.direction).to be(:north)
    end

    it 'will not change direction if unplaced' do
      expect(robot.position).to be_nil
      expect(robot.direction).to be_nil

      expect(robot.left.direction).to be_nil
    end
  end

  describe 'right' do
    it 'can turn right' do
      robot.place(Position.new(1, 1), :north)
      expect(robot.right.direction).to be(:east)
      expect(robot.right.direction).to be(:south)
      expect(robot.right.direction).to be(:west)
      expect(robot.right.direction).to be(:north)
    end

    it 'will not change direction if unplaced' do
      expect(robot.right.direction).to be_nil
    end
  end

  describe 'move' do
    context 'when placed' do
      before(:each) do
        robot.place(Position.new(1, 1), :north)
      end

      it 'can move north' do
        expect(robot.move.position).to eq(Position.new(1, 2))
      end

      it 'can move south' do
        expect(robot.left.left.move.position).to eq(Position.new(1, 0))
      end

      it 'can move east' do
        expect(robot.right.move.position).to eq(Position.new(2, 1))
      end

      it 'can move west' do
        expect(robot.left.move.position).to eq(Position.new(0, 1))
      end
    end

    it 'will not move if unplaced' do
      expect(robot.move.position).to be_nil
    end

    it 'will not move off the edge' do
      edge = Position.new(0, 0)
      expect(robot.place(edge, :south).move.position).to eq(edge)
    end
  end

  describe 'to_s' do
    it 'returns "unplaced" when unplaced' do
      expect(robot.to_s).to eq('UNPLACED')
    end

    it 'returns position and direction when placed' do
      expect(robot.place(Position.new(1, 1), :north).to_s).to eq('1,1,NORTH')
    end
  end

  describe 'report' do
    it 'can report' do
      robot.place(Position.new(1, 1), :north).report
      expect(string_writer.string).to eq("1,1,NORTH\n")
    end
  end
end
