require_relative 'input'
require_relative 'output'
require_relative 'ride'
require_relative 'vehicle'
require_relative 'simulation'

class Scoring
  def initialize(input, output)
    @input = Input.new(input)
    @output = Output.new(output)
    @score = 0
    @rides_pending = 0
    @rides_with_bonus = 0
  end

  def do
    each_vehicle_rides do |vehicle, rides|
      score = Simulation.new(
        vehicle,
        rides,
        max_steps,
        bonus
      ).score
      update_metrics(rides, score)
    end

    @score
  end

  def statistics
    {
      total_score: @score,
      rides_pending: @rides_pending,
      rides_with_bonus: @rides_with_bonus
    }
  end

  private

  def each_vehicle_rides
    @output.vehicle_rides do |_count, rides_indexes|
      vehicle = Vehicle.new
      rides = rides_indexes.map do |index|
        @input.ride(index)
      end

      yield(vehicle, rides)
    end
  end

  def update_metrics(rides, score)
    @score += score
    @rides_pending += count_pending(rides)
    @rides_with_bonus += count_with_bonus(rides)
  end

  def count_pending(rides)
    rides.select do |ride|
      !ride.completed? || ride.finish_step > max_steps
    end.count
  end

  def count_with_bonus(rides)
    rides.select do |ride|
      ride.timeless? && ride.finish_step <= max_steps
    end.count
  end

  def max_steps
    @input.max_steps
  end

  def bonus
    @input.bonus
  end
end
