class Budgets
  def initialize(bonus)
    @bonus = bonus
  end

  def add(budget)
    budgets << budget
  end

  def best_score_ride
    budget = max_score_budget
    budget.ride
  end

  private

  def max_score_budget
    budgets.max_by do |budget|
      budget.score(@bonus)
    end
  end

  def budgets
    @budgets ||= []
  end
end
