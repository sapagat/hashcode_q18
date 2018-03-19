class Budget
  attr_reader :ride

  def initialize(ride, checkpoint)
    @ride = ride
    @checkpoint = checkpoint
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

  def simulated_ride
    @simulated_ride ||= @ride.simulate(@checkpoint)
  end
end
