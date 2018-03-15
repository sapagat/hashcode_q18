require_relative '../vehicle'
require_relative '../planners/single_ride'
require_relative '../planners/first_ride_free'
require_relative '../planners/max_next_score'
require_relative '../planners/max_next_common_score'
require_relative '../planners/max_journal_score'
require_relative '../planner'
require_relative '../settings'
require_relative '../output'

module Commands
  class Plan
    def self.do(input, planner_name)
      new(input, planner_name).plan
    end

    def initialize(input, planner_name)
      @input = input
      @strategy_class = Strategy.planner_for(planner_name)
    end

    def plan
      assign_rides
      build_output
    end

    private

    def assign_rides
      puts "Planning with #{@strategy_class}"

      strategy = @strategy_class.new(settings)
      strategy.plan
    end

    def settings
      Settings.new({
        fleet: fleet,
        rides: rides,
        max_steps: @input.max_steps,
        rows: @input.grid_rows,
        columns: @input.grid_columns,
        bonus: @input.bonus
      })
    end

    def build_output
      Output.from_fleet(fleet)
    end

    def rides
      @rides ||= @input.rides
    end

    def fleet
      @fleet ||= @input.fleet
    end

    class Strategy
      PLANNERS = {
        'single_ride' => Planners::SingleRide,
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
