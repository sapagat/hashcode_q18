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

    ride.mark_as_assigned
    perform(ride)

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

  def perform(ride)
    start_step = @free_at
    lead_time = go_to(ride.origin)
    vehicle_ready = start_step + lead_time

    finish_step = ride.perform(vehicle_ready)

    go_to(ride.term)
    @free_at = finish_step
  end

  def score(ride, bonus)
    lead_time = @position.distance_to(ride.origin)
    vehicle_ready = @free_at + lead_time

    ride = ride.dup
    ride.perform(vehicle_ready)

    ride.score(bonus)
  end
end
