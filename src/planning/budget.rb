class Budget
  def initialize(ride)
    @ride = ride
  end

  def at_scenario(origin, start)
    @origin = origin
    @start = start
  end

  def score(bonus)
    compute_score(simulate_ride, bonus)
  end

  private

  def simulate_ride
    ride = @ride.dup
    ride.perform(ready)
    ride
  end

  def compute_score(ride, bonus)
    score = 0
    score += ride.distance if ride.finished_in_time?
    score += bonus if ride.timeless?
    score
  end

  def ready
    lead_time = @origin.distance_to(@ride.origin)

    @start + lead_time
  end
end
