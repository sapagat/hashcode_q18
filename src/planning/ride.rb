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

  def execute_at(initial_step)
    start = initial_step + wait_time(initial_step)
    finish = start + distance_cost

    @disposed = TimeRange.new(start, finish)

    {
      step: @disposed.finish,
      position: @vector.term
    }
  end

  def simulate(initial_step)
    copy = self.dup
    copy.execute_at(initial_step)
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

  def distance_to(position)
    @vector.distance_from_origin_to(position)
  end

  def achievable?(position, step)
    initial_step = step + cost(distance_to(position))

    start = initial_step + wait_time(initial_step)
    finish = start + distance_cost

    @available.in_range?(finish)
  end

  private

  def wait_time(step)
    @available.until_being_in_range_from(step)
  end

  def cost(distance)
    distance
  end

  def distance_cost
    mileage
  end
end
