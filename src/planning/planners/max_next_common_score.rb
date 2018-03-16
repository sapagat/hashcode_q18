require_relative '../planner'
require_relative '../resolver'
require_relative '../clock'

module Planners
  class MaxNextCommonScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      clock.next_step do |step|
        calculate_best_common_assignments(step)
      end
    end

    private

    def calculate_best_common_assignments(step)
      resolver = Resolver.new
      unassigned_rides.each do |ride|
        fleet.process_free_vehicles(step) do |vehicle|
          score = score_ride(vehicle, ride)
          resolver.add(ride, vehicle, score)
        end
      end

      resolver.solve
    end

    def score_ride(vehicle, ride)
      budget = vehicle.budget(ride)
      budget.score(bonus)
    end

    def unassigned_rides
      all_unassigned = rides.unassigned
      all_unassigned.take(MAX_RIDES_TO_COMPARE)
    end
  end
end
