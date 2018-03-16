require_relative '../planner'
require_relative '../resolver'
require_relative '../clock'

module Planners
  class MaxJournalScore < Planner
    def plan
      fleet.process do |vehicle|
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
        score = score_ride(vehicle, ride)
        resolver.add(ride, vehicle, score) unless score == 0
      end

      resolver.solve
    end

    private

    def score_ride(vehicle, ride)
      budget = vehicle.budget(ride)
      budget.score(bonus)
    end

    def rides_unassigned
      rides.unassigned
    end
  end
end
