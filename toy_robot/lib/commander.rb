require 'board'
require 'position'
require 'robot'

class Commander
  attr_accessor :robot

  def initialize(board_size)
    @board = Board.new(board_size)
    @robot = Robot.new(@board)
  end

  def process_command(command)
    case command.downcase
      when 'move' then
        @robot.move
      when 'left' then
        @robot.left
      when 'right' then
        @robot.right
      when 'report' then
        return @robot.to_s
      when /place (\d), *(\d), *(north|south|east|west)/ then
        @robot.place(Position.new($1.to_i, $2.to_i), $3.to_sym)
    end
    nil
  end
end