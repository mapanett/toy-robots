# frozen_string_literal: true

#
#  4.....
#  3.....      N
#  2.....      |
#  1.....   W -+- E
#  0.....      |
#   01234      S
#
#

require 'position'

class Board
  def initialize(size)
    @size = size
  end

  def valid_position(position)
    (position.x >= 0 && position.x < @size) && (position.y >= 0 && position.y < @size)
  end
end
