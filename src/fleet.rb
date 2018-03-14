class Fleet
  def initialize
    @vehicles = []
  end

  def add(vehicle)
    @vehicles << vehicle
  end

  def free_vehicles_at(step)
    @vehicles.select do |vehicle|
      vehicle.free?(step)
    end
  end

  def all
    @vehicles
  end

  def first_free_vehicle(step)
    @vehicles.find do |vehicle|
      vehicle.free?(step)
    end
  end
end
