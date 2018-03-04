require_relative '../src/validation'
require_relative '../src/scoring'

namespace :rides do
  desc 'Validate the output file format'
  task :validate do
    input_paths.each do |input_path|
      dataset_name = dataset_name(input_path)
      puts "Validating dataset #{dataset_name}"

      input = read_content(input_path)
      output_path = output_path_for(dataset_name)
      output = read_content(output_path)

      validation = Validation.for(input, output)

      puts "#{validation.message}"

      exit 1 if validation.result == 'failure'
    end
  end

  task :score => :validate do
    input_paths.each do |input_path|
      dataset_name = dataset_name(input_path)
      puts "Scoring dataset #{dataset_name}"

      input = read_content(input_path)
      output_path = output_path_for(dataset_name)
      output = read_content(output_path)

      score = Scoring.new(input, output).do

      puts "#{score} points"
    end
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
