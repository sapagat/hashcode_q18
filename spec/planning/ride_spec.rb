require_relative '../../src/planning/vehicle'
require_relative '../../src/planning/ride'

describe 'Ride' do
  it 'predicts the finish based on the start' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(0, 3)
    ride = Ride.new(vector, available)
    start_step = 1
    finish_step = ride.perform(start_step)

    expect(finish_step).to eq(start_step + vector.distance)
  end

  it 'waits until the earliest start has been reached' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    ride = Ride.new(vector, available)
    start_step = 0
    ride.perform(start_step)

    wait_time = 2
    expect(ride.finish_step).to eq(start_step + wait_time + vector.distance)
  end

  it 'has a score when finished in time' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    start_step = 3
    ride = Ride.new(vector, available)
    ride.perform(start_step)

    score = ride.score(a_bonus)

    expect(score).to eq(vector.distance)
  end

  it 'has better score when it has been timeless' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    start_step = 2
    ride = Ride.new(vector, available)
    ride.perform(start_step)
    bonus = a_bonus

    score = ride.score(bonus)

    expect(score).to eq(vector.distance + bonus)
  end

  it 'has null score if it has not been completed in time' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    start_step = 5
    ride = Ride.new(vector, available)
    ride.perform(start_step)
    bonus = a_bonus

    score = ride.score(a_bonus)

    expect(score).to eq(0)
  end

  def a_bonus
    2
  end
end
