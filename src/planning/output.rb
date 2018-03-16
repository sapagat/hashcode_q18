class Output
  FIRST = 0
  SECOND = 1
  LAST = -1

  def self.from_file(path)
    raw = File.read(path)
    new(raw)
  end

  def self.from_fleet(fleet)
    output = new
    fleet.process do |vehicle|
      output.add_vehicle(vehicle)
    end
    output
  end

  def initialize(content='')
    @rows = []

    read(content)
  end

  def add_vehicle(vehicle)
    @rows << Row.from_vehicle(vehicle)
  end

  def vehicles_count
    @rows.count
  end

  def to_s
    @rows.map{|row| row.to_s }.join
  end

  def vehicle_rides
    @rows.each do |row|
      yield(row.total_assignments, row.ride_ids)
    end
  end

  def save_as(path)
    File.open(path, 'w') do |file|
      file.write(self.to_s)
    end
  end

  private

  def read(content)
    content.each_line do |raw_line|
      next if raw_line.empty?

      @rows << Row.from_string(raw_line)
    end
  end

  class Row
    FIRST = 0
    SECOND = 1
    LAST = -1

    attr_reader :total_assignments, :ride_ids

    def self.from_string(str)
      line = str.split(' ').map(&:to_i)
      total_assignments = line[FIRST]
      ride_ids = line[SECOND..LAST]

      new(total_assignments, ride_ids)
    end

    def self.from_vehicle(vehicle)
      new(vehicle.total_assignments, vehicle.ride_ids)
    end

    def initialize(total_assignments, ride_ids)
      @total_assignments = total_assignments
      @ride_ids = ride_ids
    end

    def to_s
      ([@total_assignments] + @ride_ids).join(" ") + "\n"
    end
  end
end
