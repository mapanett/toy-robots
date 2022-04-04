# frozen_string_literal: true

class Direction
  LEFT = {
    north: :west,
    west: :south,
    south: :east,
    east: :north
  }.freeze

  RIGHT = {
    north: :east,
    east: :south,
    south: :west,
    west: :north
  }.freeze

  def self.left(direction)
    LEFT[direction]
  end

  def self.right(direction)
    RIGHT[direction]
  end
end
