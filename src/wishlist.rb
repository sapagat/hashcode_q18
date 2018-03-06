class Wishlist
  def initialize
    @wishes = []
  end

  def add(ride, vehicle, score)
    @wishes << {
      ride: ride,
      vehicle: vehicle,
      score: score
    }
  end

  def solve
    solve_by_max_score
  end

  private

  def solve_by_max_score
    return if @wishes.empty?

    max_score_wish = @wishes.max_by do |wish|
      wish[:score]
    end

    solve_ride(max_score_wish[:ride], max_score_wish[:vehicle])

    solve_by_max_score
  end

  def solve_ride(ride, vehicle)
    vehicle.assign(ride)

    @wishes.delete_if do |wish|
      wish[:vehicle] == vehicle || wish[:ride] == ride
    end
  end
end
