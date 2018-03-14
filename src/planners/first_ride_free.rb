require_relative '../planner'

module Planners
  class FirstRideFree < Planner
    def plan
      clock.next_step do
        free_vehicles.each do |vehicle|
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

    def free_vehicles
      fleet.free_vehicles_at(clock.current_step)
    end

    def fleet
      @settings.fleet
    end

    def clock
      @clock ||= Clock.new(@settings.max_steps)
    end
  end
end
