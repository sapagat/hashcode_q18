module Planners
  class AlwaysInTime
    def initialize(settings)
      @vehicles = settings[:vehicles]
      @rides = settings[:rides]
      @clock = Clock.new(settings[:max_steps])
      @rows = settings[:rows]
      @columns = settings[:columns]
    end

    def plan
      the_vehicle = @vehicles.first
      @clock.next_step do |step|
        next unless the_vehicle.free?(step)

        if step == 0
          the_vehicle.assign(@rides.first)
        else
          ride = @rides.find do |ride|
            next unless ride.unassigned?

            ride.start.earliest_step > max_distance_time
          end

          the_vehicle.assign(ride)
        end
      end
    end

    private

    def max_distance_time
      @rows + @columns
    end

    class Clock
      def initialize(end_of_time)
        @current_step = 0
        @end_of_time = end_of_time
      end

      def next_step
        while(@current_step <= @end_of_time) do
          yield(@current_step)
          @current_step += 1
        end
      end
    end
  end
end
