require_relative '../clock'

module Planners
  class Planner
    def initialize(settings)
      @vehicles = settings[:vehicles]
      @rides = settings[:rides]
      @clock = Clock.new(settings[:max_steps])
      @max_steps = settings[:max_steps]
      @rows = settings[:rows]
      @columns = settings[:columns]
      @bonus = settings[:bonus]
    end

    def plan
      raise 'to be implemented'
    end
  end
end
