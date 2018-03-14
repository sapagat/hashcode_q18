require_relative '../planner'

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

    def rides
      @settings.rides
    end

    def fleet
      @settings.fleet
    end

    def clock
      @clock ||= Clock.new(@settings.max_steps)
    end
  end
end
