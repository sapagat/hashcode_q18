require_relative '../planner'

module Planners
  class SingleRide < Planner
    def plan
      first_vehicle = @settings.vehicles.first
      first_ride = @settings.rides.first

      first_vehicle.assign(first_ride)
    end
  end
end
