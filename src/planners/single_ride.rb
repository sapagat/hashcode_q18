module Planners
  class SingleRide
    def initialize(settings)
      @vehicles = settings[:vehicles]
      @rides = settings[:rides]
    end

    def plan
      @vehicles.first.assign(@rides.first)
    end
  end
end
