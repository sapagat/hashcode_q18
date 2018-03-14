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

  it 'allows to forward to a another iteration' do
    clock = Clock.new(5)
    iterations = []
    clock.next_step do |step|
      iterations << step
      if step == 1
        clock.forward_to(4)
      end
    end

    expect(iterations).to eq([0,1,5])
  end
end
