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
      scored_rides = score_pending_rides(vehicle)

      scored_rides.each do |ride, score|
        next if score == 0
        resolver.add(ride, vehicle, score)
      end
      resolver.solve
    end

    def score_pending_rides(vehicle)
      rides = fetch_pending
      return [] if rides.empty?

      score_rides(vehicle, rides)
    end

    def fetch_pending
      rides = []
      @rides.each do |ride|
        next unless ride.unassigned?

        rides << ride
      end
      rides
    end

    def score_rides(vehicle, rides)
      ride_scores = Simulation.score_rides(
        vehicle,
        rides,
        @clock.current_step,
        @max_steps,
        @bonus
      )
      ride_scores
    end
  end
end
