class JourneyLog
  attr_reader :all_journeys
  def initialize
    @all_journeys = []
  end

  def start_journey(entry_station)
    @journey = Journey.new(entry_station)
  end

  def end_journey(exit_station)
    @journey.end_journey(exit_station)
    @all_journeys << @journey
    @journey = nil
  end

  def in_journey
    !@journey.nil?
  end

  def current_journey
    @journey
  end
end
