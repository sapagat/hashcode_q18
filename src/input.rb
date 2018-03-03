class Input
  THIRD = 2
  FOURTH = 3

  def initialize(content)
    @rows = []

    read(content)
  end

  def vehicles_count
    @rows.first[THIRD]
  end

  def rides_count
    @rows.first[FOURTH]
  end

  private

  def read(content)
    content.each_line do |raw_line|
      next if raw_line.empty?
      @rows << raw_line.split(' ').map { |element| element.to_i }
    end
  end
end
