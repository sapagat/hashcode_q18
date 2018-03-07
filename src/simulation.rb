require_relative 'score'

class Simulation
  attr_reader :current_step

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

  def score
    @current_step = @start_step
    @rides.each do |ride|
      break if @current_step > @max_steps

      perform(ride)
      score_ride(ride)
    end

    @score.total
  end

  private

  def perform(ride)
    start_step = @current_step
    finish_step = ride.perform(@vehicle, start_step)
    @current_step = finish_step
  end

  def score_ride(ride)
    return if ride.finish_step > @max_steps

    @score.add(ride)
  end
end
