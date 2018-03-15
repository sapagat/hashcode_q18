class Vector
  attr_reader :origin, :term

  def initialize(origin, term)
    @origin = origin
    @term = term
  end

  def distance
    @origin.distance_to(@term)
  end

  def distance_from_origin_to(position)
    @origin.distance_to(position)
  end
end
