require_relative '../planner'

module Planners
  class FirstRideFree < Planner
    def plan
      clock.next_step do |step|
        make_assignments(step)
      end
    end

    private

    def make_assignments(step)
      fleet.process_free_vehicles(step) do |vehicle|
        ride = first_unassigned_ride
        vehicle.assign(ride)
      end
    end

    def first_unassigned_ride
      rides.first_unassigned
    end
  end
end
