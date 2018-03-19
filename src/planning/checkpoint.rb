require_relative 'position'

class Checkpoint
  INITIAL_POSITION = Position.new(0, 0)
  BEGINING_OF_TIME = 0

  attr_reader :position, :step

  def self.origin
    new(INITIAL_POSITION, BEGINING_OF_TIME)
  end

  def initialize(position, step)
    @position = position
    @step = step
  end
end
