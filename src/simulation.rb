require_relative 'score'

class Simulation
  def initialize(vehicle, rides, max_steps, bonus)
    @vehicle = vehicle
    @rides = rides
    @max_steps = max_steps
    @score = Score.new(bonus)
    @current_step = 0
  end

  def score
    @rides.each do |ride|
      break if @current_step > @max_steps

      perform(ride)
      score_ride(ride)
    end

    @score.total
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
