require_relative '../src/vehicle'
require_relative '../src/ride'

describe 'Vehicle' do
  it 'can make a prevision when it will be free' do
    vehicle = Vehicle.new

    vehicle.assign(a_ride)

    expect(vehicle.free?(1)).to eq(false)
    expect(vehicle.free?(3)).to eq(true)
  end

  it 'marks the ride as assigned' do
    vehicle = Vehicle.new
    ride = a_ride

    vehicle.assign(ride)

    expect(ride.unassigned?).to eq(false)
  end

  it 'chages position once a ride has been assigned' do
    vehicle = Vehicle.new

    vehicle.assign(a_ride)

    expect(vehicle.position).to eq(term)
  end

  def a_ride
    vector = Vector.new(
      Position.new(0, 0),
      term
    )
    available = TimeRange.new(0, 3)
    Ride.new(vector, available)
  end

  def term
    Position.new(1, 1)
  end
end
