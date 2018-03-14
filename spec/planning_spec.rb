require_relative '../src/planning'

describe 'Planning' do
  it 'can plan by assigning the first ride free' do
    planning = Planning.new(input_path)

    planning.plan_by('first_ride_free')

    expect(planning.score).to eq(10)
    expect(planning.output).to eq(first_ride_free_output)
  end

  it 'can plan by max journal score' do
    planning = Planning.new(input_path)

    planning.plan_by('max_journal_score')

    expect(planning.score).to eq(10)
    expect(planning.output).to eq(max_journal_score_output)
  end

  it 'can plan by max next common score' do
    planning = Planning.new(input_path)

    planning.plan_by('max_next_common_score')

    expect(planning.score).to eq(10)
    expect(planning.output).to eq(max_next_common_score_output)
  end

  it 'can plan by max next score' do
    planning = Planning.new(input_path)

    planning.plan_by('max_next_score')

    expect(planning.score).to eq(10)
    expect(planning.output).to eq(max_next_common_score_output)
  end

  it 'can plan a single ride' do
    planning = Planning.new(input_path)

    planning.plan_by('single_ride')

    expect(planning.score).to eq(6)
    expect(planning.output).to eq(singel_ride_output)
  end

  it 'can score without executing a plan' do
    planning = Planning.new(input_path)

    planning.had_output(output_path)

    expect(planning.score).to eq(10)
  end

  def input_path
    File.join(File.dirname(__FILE__), 'fixtures', 'example.in')
  end

  def output_path
    File.join(File.dirname(__FILE__), 'fixtures', 'example.out')
  end

  def first_ride_free_output
    <<~EOF
    1 0
    2 1 2
    EOF
  end

  def max_journal_score_output
    <<~EOF
    2 0 1
    1 2
    EOF
  end

  def max_next_score_output
    <<~EOF
    1 0
    2 1 2
    EOF
  end

  def max_next_common_score_output
    <<~EOF
    1 0
    2 1 2
    EOF
  end

  def singel_ride_output
    <<~EOF
    1 0
    0
    EOF
  end
end
