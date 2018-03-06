require_relative 'planner'

module Planners
  class SingleRide < Planner
    def plan
      @vehicles.first.assign(@rides.first)
    end
  end
end
