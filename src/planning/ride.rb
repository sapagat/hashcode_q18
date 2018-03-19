require_relative 'position'
require_relative 'vector'
require_relative 'time_range'

class Ride
  attr_reader :id

  def initialize(vector, available)
    @vector = vector
    @available = available
    @disposed = TimeRange.as_null
  end

  def has_id(id)
    @id = id
  end

  def execute_from(checkpoint)
    start = earliest_start(checkpoint)
    finish = start + distance_cost

    @disposed = TimeRange.new(start, finish)

    Checkpoint.new(@vector.term, @disposed.finish)
  end

  def simulate(checkpoint)
    copy = self.dup
    copy.execute_from(checkpoint)
    copy
  end

  def unassigned?
    @disposed.nil?
  end

  def timeless?
    @disposed.same_start?(@available)
  end

  def finished_in_time?
    @available.contains?(@disposed)
  end

  def mileage
    @vector.distance
  end

  def achievable?(checkpoint)
    start = earliest_start(checkpoint)
    finish = start + distance_cost

    @available.in_range?(finish)
  end

  private

  def earliest_start(checkpoint)
    lead_distance = distance_to(checkpoint.position)
    initial_step = checkpoint.step + cost(lead_distance)
    initial_step + wait_time(initial_step)
  end

  def wait_time(step)
    @available.until_being_in_range_from(step)
  end

  def distance_to(position)
    @vector.distance_from_origin_to(position)
  end

  def cost(distance)
    distance
  end

  def distance_cost
    mileage
  end
end
