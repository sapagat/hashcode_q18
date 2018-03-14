require_relative '../input'
require_relative '../vehicle'
require_relative '../planners/single_ride'
require_relative '../planners/always_in_time'
require_relative '../planners/first_ride_free'
require_relative '../planners/max_next_score'
require_relative '../planners/max_next_common_score'
require_relative '../planners/max_journal_score'

module Commands
  class Plan
    def self.do(input, planner_name)
      new(input, planner_name).plan
    end

    def initialize(input, planner_name)
      @input = Input.new(input)
      @strategy_class = Strategy.planner_for(planner_name)
    end

    def plan
      assign_rides
      build_output
    end

    private

    def assign_rides
      puts "Planning with #{@strategy_class}"

      settings = {
        vehicles: vehicles,
        rides: rides,
        max_steps: @input.max_steps,
        rows: @input.grid_rows,
        columns: @input.grid_columns,
        bonus: @input.bonus
      }
      strategy = @strategy_class.new(settings)
      strategy.plan
    end

    def build_output
      output = ''
      vehicles.each do |vehicle|
        count = vehicle.rides.count
        line = "#{count}"
        if count > 0
          rides_list = vehicle.rides.map(&:id).join(' ')
          line += " #{rides_list}"
        end
        output << line + "\n"
      end

      output
    end

    def vehicles
      @vehicles ||= @input.vehicles
    end

    def rides
      @rides ||= @input.rides
    end

    def vehicles_count
      @input.vehicles_count
    end

    class Strategy
      PLANNERS = {
        'single_ride' => Planners::SingleRide,
        'always_in_time' => Planners::AlwaysInTime,
        'first_ride_free' => Planners::FirstRideFree,
        'max_next_score' => Planners::MaxNextScore,
        'max_next_common_score' => Planners::MaxNextCommonScore,
        'max_journal_score' => Planners::MaxJournalScore
      }
      class << self
        def planner_for(name)
          strategy = PLANNERS[name]

          strategy || default
        end

        private

        def default
          Planners::SingleRide
        end
      end
    end
  end
end
