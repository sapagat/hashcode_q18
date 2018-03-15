require_relative 'planning/commands/plan'
require_relative 'planning/commands/score'
require_relative 'planning/commands/validate'
require_relative 'planning/input'
require_relative 'planning/output'

class Planning
  attr_reader :statistics

  def initialize(path)
    @input = Input.from(path)
  end

  def plan_by(strategy_name)
    @output = Commands::Plan.do(@input, strategy_name)
  end

  def score
    compute_score
    @score
  end

  def output
    @output.to_s
  end

  def output_to(path)
    @output.save_as(path)
  end

  def had_output(path)
    @output = Output.from_file(path)
  end

  private

  def compute_score
    validate!
    scoring = Commands::Score.new(@input, @output)
    @score = scoring.do
    @statistics = scoring.statistics
  end

  def validate!
    validation = Commands::Validate.do(@input, @output)
    raise "Validation error: #{validation.message}" if validation.failure?
  end
end
