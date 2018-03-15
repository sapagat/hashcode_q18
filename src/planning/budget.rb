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
    @ride.simulate(vehicle_ready)
  end

  def compute_score(ride, bonus)
    distance_points = distance_points(ride)
    bonus_points = bonus_points(ride, bonus)

    distance_points + bonus_points
  end

  def distance_points(ride)
    return 0 unless ride.finished_in_time?

    ride.mileage
  end

  def bonus_points(ride, bonus)
    return 0 unless ride.timeless?

    bonus
  end

  def vehicle_ready
    lead_distance = @ride.distance_to(@origin)

    @start + calculate_cost(lead_distance)
  end

  def calculate_cost(distance)
    distance
  end
end
