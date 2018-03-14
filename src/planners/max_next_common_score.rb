require_relative '../planner'
require_relative '../resolver'

module Planners
  class MaxNextCommonScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      clock.next_step do |step|
        calculate_best_common_assignments
      end
    end

    private

    def calculate_best_common_assignments
      resolver = Resolver.new
      rides = fetch_pending
      rides.each do |ride|
        free_vehicles.each do |vehicle|
          score = vehicle.score(ride, @settings.bonus)
          resolver.add(ride, vehicle, score)
        end
      end

      resolver.solve
    end

    def free_vehicles
      fleet = @settings.fleet
      fleet.free_vehicles_at(clock.current_step)
    end

    def fetch_pending
      rides = []
      @settings.rides.each do |ride|
        next unless ride.unassigned?

        rides << ride
        break if rides.count == MAX_RIDES_TO_COMPARE
      end
      rides
    end

    def clock
      @clock ||= Clock.new(@settings.max_steps)
    end
  end
end
