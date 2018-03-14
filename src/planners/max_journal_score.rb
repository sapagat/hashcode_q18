require_relative '../planner'
require_relative '../resolver'

module Planners
  class MaxJournalScore < Planner
    def plan
      fleet.all.each do |vehicle|
        assign_max_score_journal(vehicle)
      end
    end

    private

    def assign_max_score_journal(vehicle)
      clock.reset
      clock.next_step do |step|
        assign_best_next_score(vehicle)

        break if vehicle.free?(step)
        clock.forward_to(vehicle.free_at - 1)
      end
    end

    def assign_best_next_score(vehicle)
      resolver = Resolver.new

      rides.unassigned.each do |ride|
        score = vehicle.score(ride, @settings.bonus)
        next if score == 0

        resolver.add(ride, vehicle, score)
      end

      resolver.solve
    end

    private

    def rides_unassigned
      rides.unassigned
    end

    def rides
      @settings.rides
    end

    def fleet
      @settings.fleet
    end

    def clock
      @clock ||= Clock.new(@settings.max_steps)
    end
  end
end
