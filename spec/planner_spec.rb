require_relative '../src/planner'

describe 'Planner' do
  describe 'Single ride' do
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

  describe 'Always in time' do
    it 'assigns a ride to arrive in time' do
      input = single_vehicle_input
      planner = Planner.new(input, 'always_in_time')
      expect(planner.plan).to eq(single_vehicle_output)
    end

    it 'assings to a single vehicle' do
      input = multiple_vehicle_input
      planner = Planner.new(input, 'always_in_time')
      expect(planner.plan).to eq(multiple_vehicle_output)
    end

    def single_vehicle_input
      <<~EOF
  2 2 1 3 1 10
  0 0 1 1 0 10
  0 0 1 1 3 10
  0 0 1 1 5 10
      EOF
    end

    def multiple_vehicle_input
      <<~EOF
  2 2 4 3 2 10
  0 0 1 1 0 10
  0 0 1 1 3 10
  0 0 1 1 5 10
      EOF
    end

    def single_vehicle_output
      <<~EOF
  2 0 2
      EOF
    end

    def multiple_vehicle_output
      <<~EOF
  2 0 2
  0
  0
  0
      EOF
    end
  end
end
