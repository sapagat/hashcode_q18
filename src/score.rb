class Score
  def initialize(bonus=0)
    @total = 0
    @bonus = bonus
  end

  def add(ride)
    return unless ride.finished_in_time?

    @total += ride.distance
    @total += @bonus if ride.timeless?
  end

  def total
    @total
  end
end
