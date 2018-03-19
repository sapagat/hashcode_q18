require_relative '../../src/planning/budget'
require_relative '../../src/planning/time_range'
require_relative '../../src/planning/ride'
require_relative '../../src/planning/checkpoint'

describe 'Budget' do
  it 'has score that depends on the ride distance' do
    ride = a_ride
    checkpoint = Checkpoint.new(vector.origin, a_bit_late)

    budget = Budget.new(ride, checkpoint)

    expect(budget.score(bonus)).to eq(ride.mileage)
  end

  it 'has a better score if the ride can be performed timeless' do
    ride = a_ride
    checkpoint = Checkpoint.new(vector.origin, on_time)

    budget = Budget.new(ride, checkpoint)

    expect(budget.score(bonus)).to eq(ride.mileage + bonus)
  end

  it 'has a bad score if the ride cannot be performed in time' do
    ride = a_ride
    checkpoint = Checkpoint.new(vector.origin, very_late)

    budget = Budget.new(ride, checkpoint)

    expect(budget.score(bonus)).to eq(0)
  end

  def a_bit_late
    1
  end

  def very_late
    10
  end

  def on_time
    0
  end

  def bonus
    1
  end

  def a_ride
    available = TimeRange.new(0, 3)
    Ride.new(vector, available)
  end

  def vector
    Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
  end
end
