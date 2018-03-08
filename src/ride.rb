require_relative 'position'
require_relative 'vector'
require_relative 'time_range'

class Ride
  attr_reader :id

  def initialize(vector, available)
    @vector = vector
    @available = available
    @completed = false
    @disposed = nil
    @assigned = false
  end

  def has_id(id)
    @id = id
  end

  def perform(vehicle_ready)
    wait_time = @available.until_being_in_range_from(vehicle_ready)

    ride_starts = vehicle_ready + wait_time

    distance = @vector.distance
    ride_ends = ride_starts + distance

    @disposed = TimeRange.new(ride_starts, ride_ends)

    ride_ends
  end

  def origin
    @vector.origin
  end

  def term
    @vector.term
  end

  def mark_as_assigned
    @assigned = true
  end

  def completed?
    !@disposed.nil?
  end

  def unassigned?
    !@assigned
  end

  def timeless?
    @disposed && @disposed.same_start?(@available)
  end

  def finished_in_time?
    @disposed && @available.contains?(@disposed)
  end

  def distance
    @vector.distance
  end

  def finish_step
    @disposed.finish
  end
end
