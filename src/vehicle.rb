class Vehicle
  attr_reader :rides
  
  def initialize
    @position = Position.new(0, 0)
    @rides = []
  end

  def assign(ride)
    @rides << ride
  end

  def go_to(other_position)
    distance = @position.distance_to(other_position)
    @position = other_position

    distance
  end
end
