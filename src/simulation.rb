require_relative 'score'

class Simulation
  attr_reader :current_step

  def initialize(vehicle, rides, max_steps, bonus)
    @vehicle = vehicle
    @rides = rides
    @max_steps = max_steps
    @score = Score.new(bonus)
    @start_step = 0
  end

  def start_from(step)
    @start_step = step
  end

  def run
    score
  end

  def score
    @current_step = @start_step
    @rides.each do |ride|
      break if @current_step > @max_steps

      perform(ride)
      score_ride(ride)
    end

    @score.total
  end

  def all_rides_completed?
    @rides.each do |ride|
      next if ride.finish_step <= @max_steps

      return false
    end

    true
  end

  private

  def perform(ride)
    distance = @vehicle.go_to(ride.start)
    @current_step += distance

    @current_step = ride.perform(@current_step)
    @vehicle.go_to(ride.finish)
  end

  def score_ride(ride)
    return if ride.finish_step > @max_steps

    @score.add(ride)
  end
end
