require_relative 'ride'
require_relative 'vehicle'

class Input
  FIRST = 0
  SECOND = 1
  THIRD = 2
  FOURTH = 3
  FIFTH = 4
  SIXTH = 5
  HEADER_OFFSET = 1

  def initialize(content)
    @rows = []

    read(content)
  end

  def vehicles_count
    header[THIRD]
  end

  def vehicles
    result = []
    vehicles_count.times do
      result << Vehicle.new
    end
    result
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
    result = []

    descriptors.each do |descriptor|
      result << build_ride(index, descriptor)
      index += 1
    end

    result
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

    ride = Ride.new(
      Start.new(start_x, start_y, earliest_start),
      Finish.new(finish_x, finish_y, latest_finish)
     )
     ride.has_id(id)
     ride
  end
end
