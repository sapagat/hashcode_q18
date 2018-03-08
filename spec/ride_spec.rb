require_relative '../src/vehicle'
require_relative '../src/ride'

describe 'Ride' do
  it 'predicts the finish based on the start' do
    vehicle = Vehicle.new
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(0, 3)
    ride = Ride.new(vector, available)
    start_step = 1
    finish_step = ride.perform(vehicle, start_step)

    expect(finish_step).to eq(start_step + ride.distance)
    expect(vehicle.position).to eq(vector.term)
  end

  it 'waits until the earliest start has been reached' do
    vehicle = Vehicle.new
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(2, 5)
    ride = Ride.new(vector, available)
    start_step = 0
    ride.perform(vehicle, start_step)

    wait_time = 2
    expect(ride.finish_step).to eq(start_step + wait_time + ride.distance)
  end
end
