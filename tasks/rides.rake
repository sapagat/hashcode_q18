require_relative '../src/planning'

namespace :rides do
  task :score do
    total_score = 0
    input_paths.each do |input_path|
      dataset_name = dataset_name(input_path)
      output_path = File.join(output_directory, "#{dataset_name}.out")
      puts "*" * 25, "Scoring dataset #{dataset_name}"

      planning = Planning.new(input_path)
      planning.had_output(output_path)

      puts "#{planning.statistics}", "#{planning.score} points"
      total_score += planning.score
    end
    puts "*" * 25, "Total points: #{total_score}"
  end

  task :plan, [:strategy] do |t, args|
    strategy = args[:strategy]
    total_score = 0
    input_paths.each do |input_path|
      score = 0
      dataset_name = dataset_name(input_path)
      output_path = File.join(output_directory, "#{dataset_name}.out")
      puts "*" * 25, "Planning dataset #{dataset_name}"

      planning = Planning.new(input_path)
      planning.plan_by(strategy)
      planning.output_to(output_path)

      score = planning.score
      statistics = planning.statistics
      puts "#{statistics}"
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
