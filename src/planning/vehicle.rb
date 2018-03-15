require_relative 'position'
require_relative 'budget'

class Vehicle
  GARAGE_POSITION = Position.new(0, 0)
  BEGINING_OF_TIME = 0

  attr_reader :position, :free_at

  def self.at_garage
    new(GARAGE_POSITION)
  end

  def initialize(position)
    @position = position
    @free_at = BEGINING_OF_TIME
  end

  def assign(ride)
    return unless ride

    perform(ride)

    assignments << ride.id
  end

  def free?(step)
    @free_at <= step
  end

  def total_assignments
    assignments.count
  end

  def ride_ids
    assignments
  end

  def perform(ride)
    step = calculate_initial_step(ride)

    result = ride.execute_at(step)

    @position = result[:position]
    @free_at = result[:step]
  end

  def budget(ride)
    budget = Budget.new(ride)
    budget.at_scenario(@position, @free_at)
    budget
  end

  private

  def cost(distance)
    distance
  end

  def calculate_initial_step(ride)
    start_step = @free_at
    lead_distance = ride.distance_to(@position)

    start_step + cost(lead_distance)
  end

  def assignments
    @assignments ||=  []
  end
end
