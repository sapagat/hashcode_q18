require_relative '../src/vehicle'

describe 'Rides' do
  it 'provides the first ride free' do
    assigned_ride = an_assigned_ride
    unassigned_ride = an_unassigned_ride

    rides = Rides.new
    rides.add(assigned_ride)
    rides.add(unassigned_ride)

    expect(rides.first_unassigned).to eq(unassigned_ride)
  end

  it 'provides a list of the rides that have not been assigned' do
    rides = Rides.new
    rides.add(an_assigned_ride)
    rides.add(an_unassigned_ride)
    rides.add(an_unassigned_ride)

    expect(rides.unassigned.count).to eq(2)
  end

  def a_ride
    vector = Vector.new(
      Position.new(0, 0),
      Position.new(1, 1)
    )
    available = TimeRange.new(0, 3)
    Ride.new(vector, available)
  end

  def an_assigned_ride
    ride = a_ride
    ride.mark_as_assigned
    ride
  end

  def an_unassigned_ride
    a_ride
  end
end
