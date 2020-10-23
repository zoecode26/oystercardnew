class Journey
attr_reader :entry_station, :single_journey
  MINIMUM_FARE = 1
  def initialize(entry_station)
    @entry_station = entry_station
    @single_journey = nil
  end

  def end_journey(exit_station)
    @single_journey = {:start => entry_station, :finish => exit_station }
    @entry_station = nil
  end

  def calculate_fare
    MINIMUM_FARE
  end

end
