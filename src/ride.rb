require_relative 'position'

class Ride
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    @wait_time = 0
  end

  def perform(current_step)
    wait_time = @start.wait_time(current_step)
    current_step += wait_time

    @start.arrived_at(current_step)

    current_step += distance
    @finish.arrived_at(current_step)
    current_step
  end

  def timeless?
    @start.just_in_time?
  end

  def finished_in_time?
    @finish.in_time?
  end

  def distance
    @start.distance_to(@finish)
  end

  def finish_step
    @finish.arrived_step
  end
end

class Finish < Position
  def initialize(x, y, latest_step)
    @latest_step = latest_step

    super(x, y)
  end

  def arrived_at(step)
    @arrived_at = step
  end

  def in_time?
    @latest_step >= @arrived_at
  end

  def arrived_step
    @arrived_at
  end
end

class Start < Position
  def initialize(x, y, earliest_step)
    @earliest_step = earliest_step

    super(x, y)
  end

  def wait_time(step)
    return 0 unless too_early?(step)

    @earliest_step - step
  end

  def arrived_at(step)
    @arrived_at = step
  end

  def just_in_time?
    @arrived_at == @earliest_step
  end

  private

  def too_early?(step)
    @earliest_step > step
  end
end
