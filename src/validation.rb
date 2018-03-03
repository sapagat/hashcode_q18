require_relative 'validation/checks'
require_relative 'output'
require_relative 'input'

module Validation
  def self.for(input, output)
    Validation.new(input, output).do
  end

  class Validation
    CHECKS = [
      Checks::VehiclesCount,
      Checks::RidesPerVehicle,
      Checks::TotalRides,
      Checks::MultipleAssignments
    ]

    def initialize(input, output)
      @input = Input.new(input)
      @output = Output.new(output)
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
  end

  class Failure
    attr_reader :message
    def initialize(message)
      @message = message
    end

    def result
      'failure'
    end
  end

  class Success
    def result
      'success'
    end

    def message
      'Validation has passed'
    end
  end
end
