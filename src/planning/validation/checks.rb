require_relative 'check'

module Validation
  module Checks
    class VehiclesCount < Check
      def check
        record_failure if @output.vehicles_count != @input.vehicles_count
      end

      def failure_message
        'The output file has the wrong number of lines'
      end
    end

    class RidesPerVehicle < Check
      def check
        @output.vehicle_rides do |count, rides|
          next if count == rides.count

          record_failure
          break
        end
      end

      def failure_message
        'Mismatch in the number of rides assigned to a vehicle'
      end
    end

    class TotalRides < Check
      def check
        total_rides_count = @input.rides_count
        total_count = 0

        @output.vehicle_rides do |count, _rides|
          total_count += count
        end

        record_failure if total_count > total_rides_count
      end

      def failure_message
        'Total rides count has been exceeded'
      end
    end

    class MultipleAssignments < Check
      def check
        assigned_rides = []
        @output.vehicle_rides do |count, rides|
          rides.each do |ride|
            if assigned_rides.include?(ride)
              record_failure
              break
            end

            assigned_rides << ride
          end
        end
      end

      def failure_message
        'A ride has been assigned more than once'
      end
    end
  end
end
