require_relative '../planner'
require_relative '../resolver'

module Planners
  class MaxNextScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      clock.next_step do |step|
        @settings.vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          calculate_best_assignments(vehicle)
        end
      end
    end

    private

    def calculate_best_assignments(vehicle)
      resolver = Resolver.new
      rides = fetch_pending
      rides.each do |ride|
        score = vehicle.score(ride, @settings.bonus)
        resolver.add(ride, vehicle, score)
      end
      resolver.solve
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
