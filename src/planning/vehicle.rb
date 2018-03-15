require_relative 'position'
require_relative 'budget'

class Vehicle
  GARAGE_POSITION = Position.new(0, 0)

  attr_reader :position, :free_at

  def self.at_garage
    new(GARAGE_POSITION)
  end

  def initialize(position)
    @position = position
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

  def total_assignments
    @rides.count
  end

  def ride_ids
    @rides.map(&:id)
  end

  def perform(ride)
    start_step = @free_at
    lead_time = go_to(ride.origin)
    vehicle_ready = start_step + lead_time

    finish_step = ride.perform(vehicle_ready)

    go_to(ride.term)
    @free_at = finish_step
  end

  def budget(ride)
    budget = Budget.new(ride)
    budget.at_scenario(@position, @free_at)
    budget
  end
end
