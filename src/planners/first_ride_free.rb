require_relative 'planner'

module Planners
  class FirstRideFree < Planner
    def plan
      @clock.next_step do |step|
        @vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          ride = first_ride_free
          vehicle.assign(ride)
        end
      end
    end

    private

    def first_ride_free
      @rides.find do |ride|
        ride.unassigned?
      end
    end

    def max_distance_time
      @rows + @columns
    end
  end
end
