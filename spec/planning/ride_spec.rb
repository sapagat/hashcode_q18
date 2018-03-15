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
    result = ride.execute_at(start_step)

    expect(result[:step]).to eq(start_step + vector.distance)
  end

  it 'waits until the earliest start has been reached' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    ride = Ride.new(vector, available)
    start_step = 0
    result = ride.execute_at(start_step)

    wait_time = 2
    expect(result[:step]).to eq(start_step + wait_time + vector.distance)
  end

  it 'does not assigned the ride on a simulation' do
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    ride = Ride.new(vector, available)
    start_step = 0
    ride.simulate(start_step)

    expect(ride.unassigned?).to eq(true)
  end

  def a_bonus
    2
  end
end
