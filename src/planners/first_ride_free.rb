require_relative '../planner'

module Planners
  class FirstRideFree < Planner
    def plan
      clock = Clock.new(@settings.max_steps)

      clock.next_step do |step|
        @settings.vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          ride = first_ride_free
          vehicle.assign(ride)
        end
      end
    end

    private

    def first_ride_free
      @settings.rides.find do |ride|
        ride.unassigned?
      end
    end
  end
end
