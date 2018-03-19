require_relative 'budget'
require_relative 'checkpoint'

class Vehicle
  attr_reader :checkpoint

  def initialize
    @checkpoint = Checkpoint.origin
  end

  def assign(ride)
    return unless ride

    perform(ride)

    assignments << ride.id
  end

  def free?(step)
    @checkpoint.step <= step
  end

  def total_assignments
    assignments.count
  end

  def ride_ids
    assignments
  end

  def perform(ride)
    @checkpoint = ride.execute_from(@checkpoint)
  end

  def budget(ride)
    Budget.new(ride, @checkpoint)
  end

  private

  def cost(distance)
    distance
  end

  def assignments
    @assignments ||=  []
  end
end
