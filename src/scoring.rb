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
  end

  def do
    each_vehicle_rides do |vehicle, rides|
      @score += Simulation.new(
        vehicle,
        rides,
        max_steps,
        bonus
      ).score
    end

    @score
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

  def max_steps
    @input.max_steps
  end

  def bonus
    @input.bonus
  end
end
