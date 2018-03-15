require_relative '../../src/planning/vehicle'
require_relative '../../src/planning/ride'

describe 'Vehicle' do
  it 'can make a prevision when it will be free' do
    vehicle = Vehicle.at_garage

    vehicle.assign(a_ride)

    expect(vehicle.free?(1)).to eq(false)
    expect(vehicle.free?(3)).to eq(true)
  end

  it 'marks the ride as assigned' do
    vehicle = Vehicle.at_garage
    ride = a_ride

    vehicle.assign(ride)

    expect(ride.unassigned?).to eq(false)
  end

  it 'chages position once a ride has been assigned' do
    vehicle = Vehicle.at_garage

    vehicle.assign(a_ride)

    expect(vehicle.position).to eq(term)
  end

  it 'can budget a ride' do
    vehicle = Vehicle.at_garage
    ride = a_ride

    budget = vehicle.budget(ride)

    expect(budget.score(any_bonus)).to eq(expected_score)
    expect(ride.completed?).to eq(false)
  end

  def any_bonus
    2
  end

  def expected_score
    4
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
