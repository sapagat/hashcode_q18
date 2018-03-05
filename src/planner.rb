require_relative 'input'
require_relative 'vehicle'
require_relative 'planners/single_ride'
require_relative 'planners/always_in_time'
require_relative 'planners/first_ride_free'

class Planner
  STRATEGIES = {
    nil => Planners::SingleRide,
    'always_in_time' => Planners::AlwaysInTime,
    'first_ride_free' => Planners::FirstRideFree
  }

  def initialize(input, planner_name=nil)
    @input = Input.new(input)
    @strategy_class = STRATEGIES[planner_name]
  end

  def plan
    assign_rides
    build_output
  end

  private

  def assign_rides
    settings = {
      vehicles: vehicles,
      rides: rides,
      max_steps: @input.max_steps,
      rows: @input.grid_rows,
      columns: @input.grid_columns
    }
    strategy = @strategy_class.new(settings)
    strategy.plan
  end

  def build_output
    output = ''
    vehicles.each do |vehicle|
      count = vehicle.rides.count
      line = "#{count}"
      if count > 0
        rides_list = vehicle.rides.map(&:id).join(' ')
        line += " #{rides_list}"
      end
      output << line + "\n"
    end

    output
  end

  def vehicles
    @vehicles ||= @input.vehicles
  end

  def rides
    @rides ||= @input.rides
  end

  def vehicles_count
    @input.vehicles_count
  end
end
