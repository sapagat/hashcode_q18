require_relative '../validation/checks'

module Commands
  class Validate
    CHECKS = [
      Validation::Checks::VehiclesCount,
      Validation::Checks::RidesPerVehicle,
      Validation::Checks::TotalRides,
      Validation::Checks::MultipleAssignments
    ]

    def self.do(input, output)
      new(input, output).do
    end

    def initialize(input, output)
      @input = input
      @output = output
    end

    def do
      CHECKS.each do |check_class|
        check = check_class.new(@input, @output)
        check.check
        next if check.passed?

        return Failure.new(check.failure_message)
      end

      Success.new
    end

    class Failure
      attr_reader :message
      def initialize(message)
        @message = message
      end

      def result
        'failure'
      end

      def failure?
        true
      end
    end

    class Success
      def result
        'success'
      end

      def message
        'Validation has passed'
      end

      def failure?
        false
      end
    end
  end
end
