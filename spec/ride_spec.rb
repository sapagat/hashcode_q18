require_relative '../src/vehicle'
require_relative '../src/ride'

describe 'Ride' do
  it 'predicts the finish based on the start' do
    vehicle = Vehicle.new
    ride = Ride.new(
    id,
     Start.new(0,0, 0),
     Finish.new(1, 1, 3)
     )
    start_step = 1
    finish_step = ride.perform(vehicle, start_step)

    expect(finish_step).to eq(start_step + ride.distance)
    expect(vehicle.position).to eq(ride.finish)
  end

  it 'waits until the earliest start has been reached' do
    vehicle = Vehicle.new
    ride = Ride.new(
     id,
     Start.new(0,0, 2),
     Finish.new(1, 1, 5)
     )
    start_step = 0
    ride.perform(vehicle, start_step)

    wait_time = 2
    expect(ride.finish_step).to eq(start_step + wait_time + ride.distance)
  end

  def id
    1234
  end
end
