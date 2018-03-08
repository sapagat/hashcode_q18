class Vector
  attr_reader :origin, :term

  def initialize(origin, term)
    @origin = origin
    @term = term
  end

  def distance
    @origin.distance_to(@term)
  end
end
