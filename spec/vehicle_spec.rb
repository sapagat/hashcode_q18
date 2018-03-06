describe 'Vehicle' do
  it 'can make a prevision when it will be free' do
    vehicle = Vehicle.new
    vehicle.assign(Ride.new(
    'AN_ID',
     Start.new(0,0, 0),
     Finish.new(1, 1, 3)
     ))

    expect(vehicle.free?(1)).to eq(false)
    expect(vehicle.free?(3)).to eq(true)
  end

  it 'marks the ride as assigned' do
    vehicle = Vehicle.new
    ride = Ride.new(
      'AN_ID',
       Start.new(0,0, 0),
       Finish.new(1, 1, 3)
     )
    vehicle.assign(ride)

    expect(ride.unassigned?).to eq(false)
  end
end
