class Fleet
  def initialize
    @vehicles = []
  end

  def add(vehicle)
    @vehicles << vehicle
  end

  def process_free_vehicles(step)
    free_vehicles_at(step).each do |vehicle|
      yield(vehicle)
    end
  end

  def process
    @vehicles.each do |vehicle|
      yield(vehicle)
    end
  end

  def first_free_vehicle(step)
    @vehicles.find do |vehicle|
      vehicle.free?(step)
    end
  end

  private

  def free_vehicles_at(step)
    @vehicles.select do |vehicle|
      vehicle.free?(step)
    end
  end
end
