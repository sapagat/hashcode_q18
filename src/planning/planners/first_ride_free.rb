require_relative '../planner'
require_relative '../clock'

module Planners
  class FirstRideFree < Planner
    def plan
      clock.next_step do
        free_vehicles.each do |vehicle|
          ride = first_unassigned_ride
          vehicle.assign(ride)
        end
      end
    end

    private

    def first_unassigned_ride
      rides.first_unassigned
    end

    def free_vehicles
      fleet.free_vehicles_at(clock.current_step)
    end
  end
end
