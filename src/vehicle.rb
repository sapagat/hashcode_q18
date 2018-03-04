class Vehicle
  def initialize
    @position = Position.new(0, 0)
  end

  def go_to(other_position)
    distance = @position.distance_to(other_position)
    @position = other_position

    distance
  end
end
