require_relative 'input'
require_relative 'output'
require_relative 'ride'
require_relative 'rides'
require_relative 'vehicle'
require_relative 'clock'
require_relative 'score'

class Scoring
  def initialize(input, output)
    @input = Input.new(input)
    @output = Output.new(output)
    @rides_pending = 0
    @rides_with_bonus = 0
  end

  def do
    @score = Score.new(@input.bonus)

    each_vehicle_rides do |vehicle, rides|
      rides.each do |ride|
        vehicle.perform(ride)
        @score.add(ride)
      end
      update_metrics(rides)
    end

    @score.total
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
      rides = Rides.new
      rides_indexes.each do |index|
        ride = @input.ride(index)
        rides.add(ride)
      end
      yield(vehicle, rides)
    end
  end

  def update_metrics(rides)
    @rides_pending += rides.count_pending
    @rides_with_bonus += rides.count_timeless
  end

  def max_steps
    @input.max_steps
  end

  def bonus
    @input.bonus
  end
end
