require_relative '../simulation'
require_relative 'planner'

module Planners
  class MaxNextScore < Planner
    MAX_RIDES_TO_COMPARE = 5000

    def plan
      @clock.next_step do |step|
        @vehicles.each do |vehicle|
          next unless vehicle.free?(step)

          ride = find_best_score(vehicle)
          vehicle.assign(ride)
        end
      end
    end

    private

    def find_best_score(vehicle)
      rides = fetch_pending(MAX_RIDES_TO_COMPARE)
      find_max_score(vehicle, rides)
    end

    def rides_pending
      @rides.select do |ride|
        ride.unassigned?
      end
    end

    def fetch_pending(max)
      rides = []
      @rides.each do |ride|
        next unless ride.unassigned?

        rides << ride
        break if rides.count == max
      end
      rides
    end

    def find_max_score(vehicle, rides)
      ride_scores = compute_max_score_per_ride(vehicle, rides)
      max_ride_score = ride_scores.max_by do |ride, score|
        score
      end
      return unless max_ride_score
      max_ride_score[0]
    end

    def compute_max_score_per_ride(vehicle, rides)
      ride_scores = {}
      rides.each do |ride|
        simulation_vehicle = vehicle.dup
        simulation_rides = [ride.dup]

        simulation = Simulation.new(simulation_vehicle, simulation_rides, @max_steps, @bonus)
        simulation.start_from(@clock.current_step)
        score = simulation.score

        ride_scores[ride] = score
      end

      ride_scores
    end
  end
end
