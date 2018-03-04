describe 'Ride' do
  it 'predicts the finish based on the start' do
    ride = Ride.new(
     Start.new(0,0, 0),
     Finish.new(1, 1, 3)
     )
    start_step = 1
    ride.perform(start_step)

    expect(ride.finish_step).to eq(start_step + ride.distance)
  end

  it 'waits until the earliest start has been reached' do
    ride = Ride.new(
     Start.new(0,0, 2),
     Finish.new(1, 1, 5)
     )
    start_step = 0
    ride.perform(start_step)

    wait_time = 2
    expect(ride.finish_step).to eq(start_step + wait_time + ride.distance)
  end
end
