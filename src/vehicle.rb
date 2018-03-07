require_relative 'simulation'
require_relative 'position'

class Vehicle
  attr_reader :rides, :position, :free_at

  def initialize
    @position = Position.new(0, 0)
    @rides = []
    @free_at = 0
  end

  def assign(ride)
    return unless ride

    update_availability(ride)
    @rides << ride
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

  def update_availability(ride)
    start_step = @free_at
    finish_step = ride.perform(self, start_step)
    @free_at = finish_step
  end
end
