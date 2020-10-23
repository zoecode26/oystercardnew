require_relative 'journey'
require_relative 'station'
class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :all_journeys, :journey
  LIMIT = 90
  MINIMUM_FARE = 1
  FINE = 6

  def initialize
    @balance = 0
    @all_journeys = []
    @log = JourneyLog.new
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    calculate_fine(:in)
    raise "please top-up, minimum fare £#{ MINIMUM_FARE }" if under_limit?
    @log.start_journey
  end

  def touch_out(exit_station)
    unless calculate_fine(:out)
      deduct(MINIMUM_FARE)
    end
  end

  def under_limit?
    @balance < MINIMUM_FARE
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def calculate_fine(action)
    case (action)

    when (:in)
      if !@journey.nil?
        deduct(FINE)
        puts "£6 fine - not touching out"
      end
    when (:out)
      if @journey.nil?
        deduct(FINE)
        puts "£6 fine - not touching in"
        true
      else
        false
      end
    end
  end
end
