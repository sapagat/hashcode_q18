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
  end

  def has_id(id)
    @id = id
  end

  def perform(vehicle, start_step)
    assign(vehicle)
    lead_time = time_from_vehicle_to_start(vehicle)
    vehicle_ready = start_step + lead_time

    wait_time = @available.until_being_in_range_from(vehicle_ready)

    ride_starts = vehicle_ready + wait_time

    distance = @vector.distance
    ride_ends = ride_starts + distance

    @disposed = TimeRange.new(ride_starts, ride_ends)
    vehicle.go_to(@vector.term)

    ride_ends
  end

  def time_from_vehicle_to_start(vehicle)
    distance = vehicle.go_to(@vector.origin)
    distance
  end

  def assign(vehicle)
    @vehicle = vehicle
  end

  def completed?
    !@disposed.nil?
  end

  def unassigned?
    !@vehicle
  end

  def timeless?
    return false unless @disposed

    @disposed.same_start?(@available)
  end

  def finished_in_time?
    @available.contains?(@disposed)
  end

  def distance
    @vector.distance
  end

  def finish_step
    @disposed.finish
  end
end
