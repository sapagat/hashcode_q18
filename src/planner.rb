require_relative 'input'
require_relative 'vehicle'

class Planner
  def initialize(input)
    @input = Input.new(input)
  end

  def plan
    assign_rides
    build_output
  end

  private

  def assign_rides
    vehicles.first.assign(rides.first)
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
    @input.rides
  end

  def vehicles_count
    @input.vehicles_count
  end
end
