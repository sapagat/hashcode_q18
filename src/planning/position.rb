class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def distance_to(position)
    (@x - position.x).abs + (@y - position.y).abs
  end

  def ==(other)
    @x == other.x && @y == other.y
  end
end
