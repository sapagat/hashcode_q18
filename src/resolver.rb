class Resolver
  def initialize(bonus=0)
    @options = []
    @bonus = bonus
  end

  def add(ride, vehicle, score)
    @options << {
      ride: ride,
      vehicle: vehicle,
      score: score
    }
  end

  def solve
    return if @options.empty?

    while(!@options.empty?) do
      option = find_max_score_option
      ride = option[:ride]
      vehicle = option[:vehicle]

      assign(ride, vehicle)
      remove_options(ride, vehicle)
    end
  end

  private

  def find_max_score_option
    @options.max_by do |option|
      option[:score]
    end
  end

  def assign(ride, vehicle)
    vehicle.assign(ride)
  end

  def remove_options(ride, vehicle)
    @options.delete_if do |option|
      option[:vehicle] == vehicle || option[:ride] == ride
    end
  end
end
