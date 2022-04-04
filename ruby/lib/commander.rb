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
    command = command.downcase
    if %w[move left right report].include?(command)
      @robot.send(command)
    elsif command =~ /place (\d), *(\d), *(north|south|east|west)/
      @robot.place(Position.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i), Regexp.last_match(3).to_sym)
    end
  end
end
