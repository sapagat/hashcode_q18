require_relative '../simulation'
require_relative 'planner'

module Planners
  class MaxNextScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      @clock.next_step do |step|
        @vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          calculate_best_assignments(vehicle)
        end
      end
    end

    private

    def calculate_best_assignments(vehicle)
      wishlist = Wishlist.new
      add_wishes(wishlist, vehicle)
      wishlist.solve
    end

    def add_wishes(wishlist, vehicle)
      scored_rides = score_pending_rides(vehicle)
      return unless scored_rides

      scored_rides.each do |ride, score|
        wishlist.add(ride, vehicle, score)
      end
    end

    def score_pending_rides(vehicle)
      rides = fetch_pending
      return if rides.empty?

      score_rides(vehicle, rides)
    end

    def fetch_pending
      rides = []
      @rides.each do |ride|
        next unless ride.unassigned?

        rides << ride
        break if rides.count == MAX_RIDES_TO_COMPARE
      end
      rides
    end

    def score_rides(vehicle, rides)
      start_step = @clock.current_step
      ride_scores = Simulation.score_rides(
        vehicle,
        rides,
        start_step,
        @max_steps,
        @bonus
      )
      ride_scores
    end
  end
end
