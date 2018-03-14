require_relative 'clock'

module Planners
  class Planner
    def initialize(settings)
      @settings = settings
    end

    def plan
      raise 'to be implemented'
    end

    class Settings
      def initialize(settings)
        @settings = settings
      end

      def fleet
        @settings[:fleet]
      end

      def rides
        @settings[:rides]
      end

      def max_steps
        @settings[:max_steps]
      end

      def rows
        @settings[:rows]
      end

      def columns
        @settings[:columns]
      end

      def bonus
        @settings[:bonus]
      end
    end
  end
end
