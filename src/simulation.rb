require_relative 'score'

class Simulation
  attr_reader :current_step

  class << self
    def score_rides(vehicle, rides, start_step, max_steps, bonus)
      ride_scores = {}
      rides.each do |ride|
        score = Simulation.score_ride(vehicle, ride, start_step, max_steps, bonus)
        ride_scores[ride] = score
      end

      ride_scores
    end

    def score_ride(vehicle, ride, start_step, max_steps, bonus)
      simulation = Simulation.new(
        vehicle.dup,
        [ride.dup],
        max_steps,
        bonus
      )
      simulation.start_from(start_step)
      simulation.run
      simulation.score
    end
  end

  def initialize(vehicle, rides, max_steps, bonus)
    @vehicle = vehicle
    @rides = rides.dup
    @max_steps = max_steps
    @score = Score.new(bonus)
    @start_step = 0
  end

  def start_from(step)
    @start_step = step
  end

  def run
    @current_step = @start_step
    @rides.each do |ride|
      break if @current_step > @max_steps

      perform(ride)
      score_ride(ride)
    end
  end

  def score
    @score.total
  end

  private

  def perform(ride)
    @current_step = @vehicle.perform(ride)
  end

  def score_ride(ride)
    return if ride.finish_step > @max_steps

    @score.add(ride)
  end
end
