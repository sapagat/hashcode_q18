class Planner
  def initialize(settings)
    @settings = settings
  end

  def plan
    raise 'to be implemented'
  end

  def rides
    @settings.rides
  end

  def fleet
    @settings.fleet
  end

  def bonus
    @settings.bonus
  end

  def max_steps
    @settings.max_steps
  end

  def clock
    @clock ||= Clock.new(@settings.max_steps)
  end
end
