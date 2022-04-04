require_relative '../lib/robot'

describe Robot do
  let(:board) { Board.new(5) }
  let(:robot) { Robot.new(board) }

  it 'starts off unplaced' do
    expect(robot.position).to be_nil
  end

  describe 'place' do
    it 'can be placed' do
      position = Position.new(1,1)
      expect(robot.place(position, :next).position).to eq(position)
    end

    it 'cannot be placed on an invalid position' do
      expect(robot.place(Position.new(1,6), :next).position).to eq(nil)
    end
  end

  describe 'left' do
    before(:each) do
      robot.place(Position.new(1,1), :north)
    end

    it 'can turn left' do
      expect(robot.left.direction).to be(:west)
      expect(robot.left.direction).to be(:south)
      expect(robot.left.direction).to be(:east)
      expect(robot.left.direction).to be(:north)
    end

    it 'will not change direction if unplaced' do
      expect(Robot.new(board).left.direction).to be_nil
    end
  end

  describe 'right' do
    before(:each) do
      robot.place(Position.new(1,1), :north)
    end

    it 'can turn right' do
      expect(robot.right.direction).to be(:east)
      expect(robot.right.direction).to be(:south)
      expect(robot.right.direction).to be(:west)
      expect(robot.right.direction).to be(:north)
    end

    it 'will not change direction if unplaced' do
      expect(Robot.new(board).right.direction).to be_nil
    end
  end

  describe 'move' do
    before(:each) do
      robot.place(Position.new(1,1), :north)
    end

    it 'can move north' do
      expect(robot.move.position).to eq(Position.new(1,2))
    end

    it 'can move south' do
      expect(robot.left.left.move.position).to eq(Position.new(1,0))
    end

    it 'can move east' do
      expect(robot.right.move.position).to eq(Position.new(2,1))
    end

    it 'can move west' do
      expect(robot.left.move.position).to eq(Position.new(0,1))
    end

    it 'will not move if unplaced' do
      expect(Robot.new(board).move.position).to be_nil
    end

    it 'will not move off the edge' do
      edge = Position.new(0,0)
      expect(Robot.new(board).place(edge, :south).move.position).to eq(edge)
    end
  end

  describe 'to_s' do
    it 'returns "unplaced" when unplaced' do
      expect(Robot.new(board).to_s).to eq('UNPLACED')
    end

    it 'returns position and direction when placed' do
      expect(robot.place(Position.new(1,1), :north).to_s).to eq('1,1,NORTH')
    end
  end
end