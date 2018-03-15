require_relative 'ride'
require_relative 'vehicle'
require_relative 'fleet'
require_relative 'rides'

class Input
  FIRST = 0
  SECOND = 1
  THIRD = 2
  FOURTH = 3
  FIFTH = 4
  SIXTH = 5
  HEADER_OFFSET = 1

  def self.from(path)
    raw = File.read(path)
    new(raw)
  end

  def initialize(content)
    @rows = []

    read(content)
  end

  def vehicles_count
    header[THIRD]
  end

  def fleet
    fleet = Fleet.new
    vehicles_count.times do
      fleet.add(Vehicle.at_garage)
    end
    fleet
  end

  def rides_count
    header[FOURTH]
  end

  def bonus
    header[FIFTH]
  end

  def max_steps
    header[SIXTH]
  end

  def grid_rows
    header[FIRST]
  end

  def grid_columns
    header[SECOND]
  end

  def ride(index)
    descriptor = @rows[index + HEADER_OFFSET]
    build_ride(index, descriptor)
  end

  def rides
    descriptors = @rows[1..-1]
    index = 0
    rides = Rides.new

    descriptors.each do |descriptor|
      ride = build_ride(index, descriptor)
      rides.add(ride)
      index += 1
    end

    rides
  end

  private

  def header
    @rows.first
  end

  def read(content)
    content.each_line do |raw_line|
      next if raw_line.empty?
      @rows << raw_line.split(' ').map { |element| element.to_i }
    end
  end

  def build_ride(id, descriptor)
    start_x = descriptor[FIRST]
    start_y = descriptor[SECOND]
    finish_x = descriptor[THIRD]
    finish_y = descriptor[FOURTH]
    earliest_start = descriptor[FIFTH]
    latest_finish = descriptor[SIXTH]
    vector = Vector.new(
      Position.new(start_x, start_y),
      Position.new(finish_x, finish_y)
    )
    available = TimeRange.new(earliest_start, latest_finish)

    ride = Ride.new(vector, available)
    ride.has_id(id)
    ride
  end
end
