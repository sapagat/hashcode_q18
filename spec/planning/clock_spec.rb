require_relative '../../src/planning/clock'

describe 'Clock' do
  it 'iterates until reached a maximum' do
    clock = Clock.new(2)
    iterations = []
    clock.next_step do |step|
      iterations << step
    end

    expect(iterations).to eq([0,1,2])
  end
end
