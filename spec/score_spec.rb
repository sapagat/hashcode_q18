require_relative '../src/ride'
require_relative '../src/score'

describe 'Score' do
  it 'gives points to a ride performed in time' do
    ride = Ride.new(
      id,
      Start.new(0,0, very_early),
      Finish.new(1, 1, very_late)
    )
    ride.perform(very_early)

    scoring = Score.new()
    scoring.add(ride)

    expect(scoring.total).to eq(ride.distance)
  end

  it 'gives points to multiple rides arrived in time' do
    first_ride = Ride.new(
      id,
      Start.new(0,0, very_early),
      Finish.new(1,1, very_late)
    )
    first_ride.perform(very_early)

    second_ride = Ride.new(
      id,
      Start.new(1,1, very_early),
      Finish.new(2,2, very_late)
    )
    second_ride.perform(early)

    scoring = Score.new()
    scoring.add(first_ride)
    scoring.add(second_ride)

    expect(scoring.total).to eq(first_ride.distance + second_ride.distance)
  end

  it 'does not give points to a ride that did not finish in time' do
    ride = Ride.new(
      id,
      Start.new(0,0, very_early),
      Finish.new(1, 1, very_early)
    )
    ride.perform(very_late)

    scoring = Score.new()
    scoring.add(ride)

    expect(scoring.total).to eq(0)
  end

  it 'gives extra points if the ride was timeless' do
    ride = Ride.new(
      id,
      Start.new(0,0, very_early),
      Finish.new(1, 1, soon)
    )
    bonus = 5

    ride.perform(very_early)

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

  def id
    1234
  end
end
