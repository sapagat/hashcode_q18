require_relative '../src/vehicle'
require_relative '../src/ride'

describe 'Vehicle' do
  it 'can make a prevision when it will be free' do
    vehicle = Vehicle.new
    ride = Ride.new(
     Start.new(0,0, 0),
     Finish.new(1, 1, 3)
     )

    vehicle.assign(ride)

    expect(vehicle.free?(1)).to eq(false)
    expect(vehicle.free?(3)).to eq(true)
  end

  it 'marks the ride as assigned' do
    vehicle = Vehicle.new
    ride = Ride.new(
       Start.new(0,0, 0),
       Finish.new(1, 1, 3)
     )
    vehicle.assign(ride)

    expect(ride.unassigned?).to eq(false)
  end

  it 'chages position once a ride has been assigned' do
    vehicle = Vehicle.new
    start_position = Start.new(0,0, 0)
    finish_position = Finish.new(1, 1, 3)
    ride = Ride.new(
       start_position,
       finish_position
     )
    vehicle.assign(ride)

    expect(vehicle.position).to eq(finish_position)
  end
end
