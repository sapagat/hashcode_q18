require_relative 'planner'

module Planners
  class AlwaysInTime < Planner
    def plan
      the_vehicle = @vehicles.first
      @clock.next_step do |step|
        next unless the_vehicle.free?(step)

        if step == 0
          the_vehicle.assign(@rides.first)
        else
          ride = @rides.find do |ride|
            next unless ride.unassigned?

            ride.start.earliest_step > max_distance_time
          end

          the_vehicle.assign(ride)
        end
      end
    end

    private

    def max_distance_time
      @rows + @columns
    end
  end
end
