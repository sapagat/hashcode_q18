class Output
  FIRST = 0
  SECOND = 1
  LAST = -1

  def self.from(path)
    raw = File.read(path)
    new(raw)
  end

  def initialize(content)
    @rows = []
    @raw = content

    read(content)
  end

  def vehicles_count
    @rows.count
  end

  def to_s
    @raw
  end

  def vehicle_rides
    @rows.each do |line|
      rides_count = line[FIRST]
      rides = line[SECOND..LAST]

      yield(rides_count, rides)
    end
  end

  def save_as(path)
    File.open(path, 'w') do |file|
      file.write(@raw)
    end
  end

  private

  def read(content)
    content.each_line do |raw_line|
      next if raw_line.empty?
      @rows << raw_line.split(' ').map { |element| element.to_i }
    end
  end
end
