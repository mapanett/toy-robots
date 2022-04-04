class Position
  include Comparable

  DIRECTION_OFFSETS = {
      north: { x: 0, y: 1},
      south: { x: 0, y: -1},
      east: {x: 1, y: 0},
      west: {x: -1, y: 0}
  }

  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def <=> other
    x == other.x ? y <=> other.y : x <=> other.x
  end

  def next(direction)
    offset = DIRECTION_OFFSETS[direction]
    Position.new(x + offset[:x], y + offset[:y])
  end
end