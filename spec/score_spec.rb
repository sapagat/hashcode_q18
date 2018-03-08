require_relative '../src/ride'
require_relative '../src/score'

describe 'Score' do
  it 'gives points to a ride performed in time' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(very_early, very_late)
    ride = Ride.new(vector, available)
    ride.perform(very_early)

    scoring = Score.new()
    scoring.add(ride)

    expect(scoring.total).to eq(ride.distance)
  end

  it 'gives points to multiple rides arrived in time' do
    first_vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    first_available = TimeRange.new(very_early, very_late)
    first_ride = Ride.new(first_vector, first_available)
    first_ride.perform(very_early)

    second_vector = Vector.new(
      Position.new(1, 1),
      Position.new(2, 2)
    )
    second_available = TimeRange.new(very_early, very_late)
    second_ride = Ride.new(second_vector, second_available)
    second_ride.perform(early)

    scoring = Score.new()
    scoring.add(first_ride)
    scoring.add(second_ride)

    expect(scoring.total).to eq(first_ride.distance + second_ride.distance)
  end

  it 'does not give points to a ride that did not finish in time' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(very_early, very_early)
    ride = Ride.new(vector, available)
    ride.perform(very_late)

    scoring = Score.new()
    scoring.add(ride)

    expect(scoring.total).to eq(0)
  end

  it 'gives extra points if the ride was timeless' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(very_early, soon)
    ride = Ride.new(vector, available)
    ride.perform(very_early)

    bonus = 5
    scoring = Score.new(bonus)
    scoring.add(ride)

    expect(scoring.total).to eq(bonus + ride.distance)
  end

  def very_early
    0
  end

  def early
    2
  end

  def soon
    5
  end

  def very_late
    5000
  end
end
