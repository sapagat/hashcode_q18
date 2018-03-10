class Rides
  def initialize
    @rides = []
  end

  def add(ride)
    @rides << ride
  end

  def count_pending
    @rides.select do |ride|
      !ride.finished_in_time?
    end.count
  end

  def count_timeless
    @rides.select do |ride|
      ride.timeless?
    end.count
  end

  def each
    @rides.each do |ride|
      yield(ride)
    end
  end
end
