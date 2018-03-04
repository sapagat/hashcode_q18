require_relative '../src/scoring'

describe 'Scoring' do
  it 'computes the score for the simulation' do
    expect(Scoring.new(input, output).do).to eq(10)
  end

  it 'computes the score of a single vehicle' do
    expect(Scoring.new(input, single_vehicle_output).do).to eq(6)
  end

  it 'stops when the number of the steps of the simulation has been reached' do
    expect(Scoring.new(very_few_steps_input, output).do).to eq(0)
  end

  def input
    <<~EOF
3 4 2 3 2 10
0 0 1 3 2 9
1 2 1 0 0 9
2 0 2 2 0 9
    EOF
  end

  def very_few_steps_input
    <<~EOF
3 4 2 3 2 1
0 0 1 3 2 9
1 2 1 0 0 9
2 0 2 2 0 9
    EOF
  end

  def output
    <<~EOF
1 0
2 2 1
    EOF
  end

  def single_vehicle_output
    <<~EOF
1 0
0
    EOF
  end
end
