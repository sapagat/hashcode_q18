require_relative '../../../src/planning/commands/score'

describe 'Score' do
  it 'computes the score for the simulation' do
    expect(Commands::Score.new(input, output).do).to eq(10)
  end

  def input
    raw = <<~EOF
      3 4 2 3 2 10
      0 0 1 3 2 9
      1 2 1 0 0 9
      2 0 2 2 0 9
        EOF
    Input.new(raw)
  end


  def output
    raw = <<~EOF
            1 0
            2 2 1
            EOF
    Output.new(raw)
  end
end
