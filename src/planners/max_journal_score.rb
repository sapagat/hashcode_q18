require_relative 'planner'
require_relative '../resolver'

module Planners
  class MaxJournalScore < Planner
    def plan
      @vehicles.each do |vehicle|
        assign_max_score_journal(vehicle)
      end
    end

    private

    def assign_max_score_journal(vehicle)
      @clock.reset
      @clock.next_step do |step|
        assign_best_next_score(vehicle)

        break if vehicle.free?(step)
        @clock.forward_to(vehicle.free_at - 1)
      end
    end

    def assign_best_next_score(vehicle)
      resolver = Resolver.new

      each_pending_ride do |ride|
        score = vehicle.score(ride, @bonus)
        next if score == 0
        
        resolver.add(ride, vehicle, score)
      end

      resolver.solve
    end

    private

    def each_pending_ride
      @rides.each do |ride|
        next unless ride.unassigned?

        yield(ride)
      end
    end
  end
end