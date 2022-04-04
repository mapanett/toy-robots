# frozen_string_literal: true

require 'direction'

class Robot
  attr_reader :position, :direction

  def initialize(board, output)
    @board = board
    @position = nil
    @direction = nil
    @output = output
  end

  def place(position, direction)
    if @board.valid_position(position)
      @position = position
      @direction = direction
    end

    self
  end

  def left
    @direction = Direction.left(@direction) unless @direction.nil?
    self
  end

  def right
    @direction = Direction.right(@direction) unless @direction.nil?
    self
  end

  def move
    unless @position.nil?
      next_position = @position.next(@direction)
      @position = next_position if @board.valid_position(next_position)
    end
    self
  end

  def report
    @output.puts(self.to_s)
  end

  def to_s
    return 'UNPLACED' if @position.nil?

    "#{position.x},#{position.y},#{direction.to_s.upcase}"
  end
end
