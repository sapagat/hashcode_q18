require_relative 'planner'
require_relative '../wishlist'

module Planners
  class MaxNextCommonScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      @clock.next_step do |step|
        calculate_best_common_assignments
      end
    end

    private

    def calculate_best_common_assignments
      wishlist = Wishlist.new
      each_free_vehicle do |vehicle|
        add_wishes(wishlist, vehicle)
      end

      wishlist.solve
    end

    def each_free_vehicle
      @vehicles.each do |vehicle|
        next unless vehicle.free?(@clock.current_step)

        yield(vehicle)
      end
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
      ride_scores = {}
      rides.each do |ride|
        simulation = Simulation.new(
          vehicle.dup,
          [ride],
          @max_steps,
          @bonus
        )
        simulation.start_from(@clock.current_step)
        score = simulation.score

        ride_scores[ride] = score
      end

      ride_scores
    end
  end
end
