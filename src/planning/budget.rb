class Budget
  attr_reader :ride

  def initialize(ride, origin, start)
    @ride = ride
    @origin = origin
    @start = start
  end

  def score(bonus)
    distance_points + bonus_points(bonus)
  end

  private

  def distance_points
    return 0 unless simulated_ride.finished_in_time?

    simulated_ride.mileage
  end

  def bonus_points(bonus)
    return 0 unless simulated_ride.timeless?

    bonus
  end

  def vehicle_ready
    lead_distance = @ride.distance_to(@origin)

    @start + calculate_cost(lead_distance)
  end

  def calculate_cost(distance)
    distance
  end

  def simulated_ride
    @simulated_ride ||= @ride.simulate(vehicle_ready)
  end
end
