require_relative '../planner'

module Planners
  INITIAL_STEP = 0
  class SingleRide < Planner
    def plan
      first_vehicle = fleet.first_free_vehicle(INITIAL_STEP)
      first_ride = rides.first

      first_vehicle.assign(first_ride)
    end

    private

    def rides
      @settings.rides
    end

    def fleet
      @settings.fleet
    end
  end
end
