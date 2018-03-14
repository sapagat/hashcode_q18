class Clock
  attr_reader :current_step

  def initialize(end_of_time)
    @current_step = 0
    @end_of_time = end_of_time
  end

  def next_step
    while(@current_step <= @end_of_time) do
      inform
      yield(@current_step)
      @current_step += 1
    end
  end

  def forward_to(step)
    @current_step = step
  end

  def reset
    @current_step = 0
  end

  private

  def inform
    return unless (@current_step > 0 && @current_step % 10000 == 0)

    puts "Still in progress (#{@current_step}/#{@end_of_time}) ..."
  end
end
