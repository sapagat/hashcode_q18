require_relative 'simulation'

class Vehicle
  attr_reader :rides

  def initialize
    @position = Position.new(0, 0)
    @rides = []
    @free_at = 0
  end

  def assign(ride)
    return unless ride

    ride.assign(self)
    @rides << ride

    update_availability
  end

  def free?(step)
    @free_at <= step
  end

  def go_to(other_position)
    distance = @position.distance_to(other_position)
    @position = other_position

    distance
  end

  private

  def update_availability
    max_steps = 1000000000
    bonus = 0

    simulation = Simulation.new(self, @rides, max_steps, bonus)
    simulation.run
    @free_at = simulation.current_step
  end
end
