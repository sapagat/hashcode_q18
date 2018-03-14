require_relative '../src/fleet'

describe 'Fleet' do
  it 'provides the list of free vehicles' do
    free_vehicle = a_vehicle
    busy_vehicle = a_vehicle
    busy_vehicle.assign(a_ride)
    fleet = Fleet.new
    fleet.add(free_vehicle)
    fleet.add(busy_vehicle)
    step = 1

    expect(fleet.free_vehicles_at(step)).to include(free_vehicle)
    expect(fleet.free_vehicles_at(step)).not_to include(busy_vehicle)
  end

  it 'provides the first vehicle free available' do
    a_free_vehicle = a_vehicle
    another_free_vehicle = a_vehicle
    fleet = Fleet.new
    fleet.add(a_free_vehicle)
    fleet.add(another_free_vehicle)
    step = 1

    expect(fleet.first_free_vehicle(step)).to eq(a_free_vehicle)
  end

  def a_vehicle
    Vechile.new
  end

  def a_ride
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(0, 3)
    Ride.new(vector, available)
  end
end