require_relative '../planner'
require_relative '../budgets'

module Planners
  class MaxJournalScore < Planner
    def plan
      fleet.process do |vehicle|
        assign_journal(vehicle)
      end
    end

    private

    def assign_journal(vehicle)
      while(any_ride_achievable?(vehicle)) do
        assign_best_ride(vehicle)
      end
    end

    def assign_best_ride(vehicle)
      budgets = budget_achievable_rides(vehicle)
      vehicle.assign(budgets.best_score_ride)
    end

    def budget_achievable_rides(vehicle)
      budgets = Budgets.new(bonus)
      rides.process_achievable(vehicle.position, vehicle.free_at) do |ride|
        budget = vehicle.budget(ride)
        budgets.add(budget)
      end

      budgets
    end

    def any_ride_achievable?(vehicle)
      rides.achievable_count(vehicle.position, vehicle.free_at) > 0
    end
  end
end
