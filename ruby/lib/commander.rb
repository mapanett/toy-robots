# frozen_string_literal: true

require 'board'
require 'position'
require 'robot'

class Commander
  attr_accessor :robot

  def initialize(board_size, output)
    @board = Board.new(board_size)
    @robot = Robot.new(@board, output)
  end

  def process_command(command)
    case command.downcase
    when 'move'
      @robot.move
    when 'left'
      @robot.left
    when 'right'
      @robot.right
    when 'report'
      return @robot.to_s
    when /place (\d), *(\d), *(north|south|east|west)/
      @robot.place(Position.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i), Regexp.last_match(3).to_sym)
    end
    nil
  end
end
