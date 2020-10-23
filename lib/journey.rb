class Journey
attr_reader :entry_station, :single_journey
  def initialize(entry_station)
    @entry_station = entry_station
    @single_journey = nil
  end

  def in_journey
    if @entry_station != nil
      return true
    else return false
    end
  end

  def end_journey(exit_station)
    @single_journey = {:start => entry_station, :finish => exit_station }
    @entry_station = nil
  end

end
