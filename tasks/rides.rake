require_relative '../src/commands/validate'
require_relative '../src/commands/score'
require_relative '../src/commands/plan'

namespace :rides do
  task :score do
    each_dataset do |name, input, output|
      score = 0
      puts "*" * 25, "Scoring dataset #{name}"

      validation = Commands::Validate.do(input, output)

      puts "#{validation.message}"

      validation.result

      if validation.result == 'success'
        score = Commands::Score.do(input, output)
      end

      puts "#{score} points"
    end
    puts "*" * 25
  end

  task :plan, [:strategy] do |t, args|
    strategy = args[:strategy]
    total_score = 0
    each_input do |name, input|

      score = 0
      puts "*" * 25, "Planning dataset #{name}"
      output = Commands::Plan.do(input, strategy)

      path = File.join(output_directory, "#{name}.out")
      File.open(path, 'w') do |file|
        file.write(output)
      end

      validation = Commands::Validate.do(input, output)

      puts "#{validation.message}"

      validation.result

      if validation.result == 'success'
        scoring = Commands::Score.new(input, output)
        score = scoring.do
        statistics = scoring.statistics
        puts "#{statistics}"
      end

      puts "#{score} points"
      total_score += score
    end
      puts "*" * 25, "Total points: #{total_score}"
  end

  def output_path_for(dataset_name)
     File.join(output_directory, "#{dataset_name}.out")
  end

  def dataset_name(input_path)
    input_path.split('/')[-1].sub('.in', '')
  end

  def read_content(path)
    File.read(path)
  end

  def each_dataset
    input_paths.each do |input_path|
      dataset_name = dataset_name(input_path)
      output_path = output_path_for(dataset_name)

      input = read_content(input_path)
      output = read_content(output_path)

      yield(dataset_name, input, output)
    end
  end

  def each_input
    input_paths.each do |input_path|
      dataset_name = dataset_name(input_path)
      input = read_content(input_path)

      yield(dataset_name, input)
    end
  end

  def input_paths
    Dir[File.join(input_directory, '*.in')]
  end

  def input_directory
    File.join(File.dirname(__FILE__), '..', 'input')
  end

  def output_directory
    File.join(File.dirname(__FILE__), '..', 'output')
  end
end
