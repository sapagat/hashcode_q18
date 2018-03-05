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

    class Clock
      def initialize(end_of_time)
        @current_step = 0
        @end_of_time = end_of_time
      end

      def next_step
        while(@current_step <= @end_of_time) do
          inform
          yield(@current_step)
          @current_step += 1
        end
      end

      private

      def inform
        return unless @current_step % 100000 == 0

        puts "Still in progress (#{@current_step}/#{@end_of_time}) ..."
      end
    end
  end
end
