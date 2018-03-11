require_relative 'planner'
require_relative '../resolver'

module Planners
  class MaxNextCommonScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      @clock.next_step do |step|
        calculate_best_common_assignments
      end
    end

    private

    def calculate_best_common_assignments
      resolver = Resolver.new(@bonus)
      rides = fetch_pending
      rides.each do |ride|
        each_free_vehicle do |vehicle|
          score = vehicle.score(ride, @bonus)
          resolver.add(ride, vehicle, score)
        end
      end

      resolver.solve
    end

    def each_free_vehicle
      @vehicles.each do |vehicle|
        next unless vehicle.free?(@clock.current_step)

        yield(vehicle)
      end
    end

    def fetch_pending
      rides = []
      @rides.each do |ride|
        next unless ride.unassigned?

        rides << ride
        break if rides.count == MAX_RIDES_TO_COMPARE
      end
      rides
    end
  end
end
