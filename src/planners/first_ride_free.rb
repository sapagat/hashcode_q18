require_relative '../clock'

module Planners
  class FirstRideFree
    def initialize(settings)
      @vehicles = settings[:vehicles]
      @rides = settings[:rides]
      @clock = Clock.new(settings[:max_steps])
      @rows = settings[:rows]
      @columns = settings[:columns]
    end

    def plan
      @clock.next_step do |step|
        @vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          ride = first_ride_free
          vehicle.assign(ride)
        end
      end
    end

    private

    def first_ride_free
      @rides.find do |ride|
        ride.unassigned?
      end
    end

    def max_distance_time
      @rows + @columns
    end
  end
end
