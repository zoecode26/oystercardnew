class Journey
attr_reader :entry_station, :single_journey
  MINIMUM_FARE = 1
  def initialize(entry_station)
    @entry_station = entry_station
    @single_journey = nil
  end

  def end_journey(exit_station)
    puts "test"
    @single_journey = {:start => @entry_station, :finish => exit_station }
    @entry_station = nil
    puts @single_journey
  end

  def calculate_fare
    puts @single_journey
    fare = @single_journey[:start].zone - @single_journey[:finish].zone
    fare = fare.abs
    fare += MINIMUM_FARE
  end

end
