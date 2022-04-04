# frozen_string_literal: true

require 'board'
require 'position'
require 'robot'

class Commander
  PLACE_REGEX = /place (?<x>\d), *(?<y>\d), *(?<direction>north|south|east|west)/.freeze

  attr_accessor :robot

  def initialize(board_size, output)
    @board = Board.new(board_size)
    @robot = Robot.new(@board, output)
  end

  def process_command(command)
    command = command.downcase
    if %w[move left right report].include?(command)
      @robot.send(command)
    elsif match = command.match(PLACE_REGEX)
      @robot.place(Position.new(match[:x].to_i, match[:y].to_i), match[:direction].to_sym)
    end
  end
end
