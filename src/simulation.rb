require_relative 'score'

class Simulation
  class << self
    def score_rides(vehicle, rides, bonus)
      ride_scores = {}
      rides.each do |ride|
        simulation = Simulation.new(
          [ride.dup],
          bonus
        )
        simulation.run(vehicle.position, vehicle.free_at)
        simulation.score
        ride_scores[ride] = simulation.score
      end

      ride_scores
    end
  end

  def initialize(rides, bonus)
    @rides = rides
    @score = Score.new(bonus)
  end

  def run(position, start)
    step = start
    @rides.each do |ride|
      lead_time = position.distance_to(ride.origin)
      vehicle_ready = step + lead_time
      step = ride.perform(vehicle_ready)
      position = ride.term

      @score.add(ride)
    end
  end

  def score
    @score.total
  end
end
