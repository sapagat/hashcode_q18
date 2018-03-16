require_relative '../rides'
require_relative '../vehicle'

module Commands
  class Score
    def self.do(input, output)
      new(input, output).do
    end

    def initialize(input, output)
      @input = input
      @output = output
      @rides_pending = 0
      @rides_with_bonus = 0
      @score = 0
    end

    def do
      each_vehicle_rides do |vehicle, rides|
        rides.process do |ride|
          budget = vehicle.budget(ride)

          vehicle.perform(ride)

          @score += budget.score(bonus)
        end
        update_metrics(rides)
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
        vehicle = Vehicle.at_garage
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
end
