class TimeRange
  attr_reader :start, :finish

  def self.as_null
    Null.new
  end

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def until_being_in_range_from(step)
    return 0 if step > @start

    @start - step
  end

  def same_start?(range)
    @start == range.start
  end

  def contains?(range)
    in_range?(range.start) && in_range?(range.finish)
  end

  private

  def in_range?(step)
    step >= @start && step <= @finish
  end

  class Null
    def start
      -1
    end

    def finish
      -1
    end

    def same_start?(range)
      false
    end

    def nil?
      true
    end
  end
end
