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
    (0 <= position.x && position.x < @size) && (0 <= position.y && position.y < @size)
  end
end