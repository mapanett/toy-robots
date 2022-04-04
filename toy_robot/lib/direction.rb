class Direction
  LEFT = {
      :north => :west,
      :west  => :south,
      :south => :east,
      :east  => :north
  }

  RIGHT = {
      :north => :east,
      :east  => :south,
      :south => :west,
      :west  => :north
  }

  def self.left direction
    LEFT[direction]
  end

  def self.right direction
    RIGHT[direction]
  end
end