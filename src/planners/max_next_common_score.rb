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
      unassigned_rides.each do |ride|
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

    def unassigned_rides
      all_unassigned = @settings.rides.unassigned
      all_unassigned.take(MAX_RIDES_TO_COMPARE)
    end

    def clock
      @clock ||= Clock.new(@settings.max_steps)
    end
  end
end
