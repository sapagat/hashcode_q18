require_relative '../../../src/planning/commands/validate'

describe 'Validate' do
  it 'passes when the output is correct' do
    output = correct_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('success')
    expect(validation.message).to eq('Validation has passed')
  end

  it 'checks the file has enough lines' do
    output = less_lines_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('failure')
    expect(validation.message).to eq('The output file has the wrong number of lines')
  end

  it 'checks the file has not too many lines' do
    output = too_many_lines_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('failure')
    expect(validation.message).to eq('The output file has the wrong number of lines')
  end

  it 'checks the number of rides assigned to a vehicle' do
    output = rides_mismatch_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('failure')
    expect(validation.message).to eq('Mismatch in the number of rides assigned to a vehicle')
  end

  it 'checks the number of total rides has not been exceeded' do
    output = rides_exceeded_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('failure')
    expect(validation.message).to eq('Total rides count has been exceeded')
  end

  it 'checks a ride has been assigned only once' do
    output = multiple_assignments_output

    validation = Commands::Validate.do(input, output)

    expect(validation.result).to eq('failure')
    expect(validation.message).to eq('A ride has been assigned more than once')
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

  def less_lines_output
    raw = <<~EOF
          1 0
          EOF
    Output.new(raw)
  end

  def too_many_lines_output
    raw = <<~EOF
          1 0
          1 1
          1 2
          EOF
    Output.new(raw)
  end

  def correct_output
    raw = <<~EOF
          1 0
          2 2 1
          EOF
    Output.new(raw)
  end

  def expected_score
    10
  end

  def rides_mismatch_output
    raw = <<~EOF
          1 0 1
          2 2 1
          EOF
    Output.new(raw)
  end

  def rides_exceeded_output
    raw = <<~EOF
          2 0 1
          2 2 1
          EOF
    Output.new(raw)
  end

  def multiple_assignments_output
    raw = <<~EOF
          1 0
          2 2 0
          EOF
    Output.new(raw)
  end
end
