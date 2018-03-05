require_relative '../src/planner'

describe 'Planner' do
  it 'assigns single ride when only one vehicle' do
    input = single_vehicle_input
    planner = Planner.new(input)
    expect(planner.plan).to eq(single_vehicle_output)
  end

  it 'assigns single ride when multiple vehicles' do
    input = multiple_vehicle_input
    planner = Planner.new(input)
    expect(planner.plan).to eq(multiple_vehicle_output)
  end

  def single_vehicle_input
    <<~EOF
3 4 1 3 1 10
0 0 1 3 2 9
1 2 1 0 0 9
2 0 2 2 0 9
    EOF
  end

  def single_vehicle_output
    <<~EOF
1 0
    EOF
  end

  def multiple_vehicle_input
    <<~EOF
3 4 3 3 3 10
0 0 1 3 2 9
1 2 1 0 0 9
2 0 2 2 0 9
    EOF
  end

  def multiple_vehicle_output
    <<~EOF
1 0
0
0
    EOF
  end
end
