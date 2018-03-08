require_relative '../src/resolver'

describe 'Resolver' do
  it 'solves rides without conflicts easily' do
    one_ride = double(:ride)
    other_ride = double(:other_ride)
    first_vehicle = a_vehicle
    second_vehicle = a_vehicle

    resolver = Resolver.new
    resolver.add(one_ride, first_vehicle, any_score)
    resolver.add(other_ride, second_vehicle, any_score)

    result = resolver.solve

    expect(first_vehicle).to have_received(:assign).with(one_ride)
    expect(second_vehicle).to have_received(:assign).with(other_ride)
  end

  it 'soves a ride by its higher score option' do
    the_ride = double(:ride)
    first_vehicle = a_vehicle
    second_vehicle = a_vehicle

    resolver = Resolver.new
    resolver.add(the_ride, first_vehicle, 0)
    resolver.add(the_ride, second_vehicle, 10)

    result = resolver.solve

    expect(first_vehicle).not_to have_received(:assign).with(the_ride)
    expect(second_vehicle).to have_received(:assign).with(the_ride)
  end

  it 'can fallback into a second best score' do
    the_ride = double(:ride)
    other_ride = double(:other_ride)
    first_vehicle = a_vehicle
    second_vehicle = a_vehicle

    resolver = Resolver.new
    resolver.add(the_ride, first_vehicle, 5)
    resolver.add(other_ride, first_vehicle, 5)

    resolver.add(the_ride, second_vehicle, 10)
    resolver.add(other_ride, second_vehicle, 8)

    result = resolver.solve

    expect(second_vehicle).to have_received(:assign).with(the_ride)
    expect(first_vehicle).to have_received(:assign).with(other_ride)
  end

  def any_score
    1
  end

  def a_vehicle
    vehicle_double = double(:vehicle)
    allow(vehicle_double).to receive(:assign)
    vehicle_double
  end
end
