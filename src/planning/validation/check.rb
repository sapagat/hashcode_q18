module Validation
  module Checks
    class Check
      attr_reader :failure

      def initialize(input, output)
        @input = input
        @output = output
        @failure = nil
      end

      def check
        'to be implemented!'
      end

      def passed?
        !@failure
      end

      def failure_message
        'check failure'
      end

      private

      def record_failure
        @failure = true
      end
    end
  end
end
