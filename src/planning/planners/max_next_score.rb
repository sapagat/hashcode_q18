require_relative '../planner'
require_relative '../resolver'
require_relative '../clock'

module Planners
  class MaxNextScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      clock.next_step do |step|
        fleet.process_free_vehicles(step) do |vehicle|
          calculate_best_assignments(vehicle)
        end
      end
    end

    private

    def calculate_best_assignments(vehicle)
      resolver = Resolver.new
      unassigned_rides.each do |ride|
        score = score_ride(vehicle, ride)
        resolver.add(ride, vehicle, score)
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

    def free_vehicles
      fleet.free_vehicles_at(clock.current_step)
    end
  end
end
