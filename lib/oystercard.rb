require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'
class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :log, :journey
  LIMIT = 90
  MINIMUM_FARE = 1
  FINE = 6

  def initialize
    @balance = 0
    @log = JourneyLog.new
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    calculate_fine(:in)
    raise "please top-up, minimum fare £#{ MINIMUM_FARE }" if under_limit?
    @log.start_journey(entry_station)
  end

  def touch_out(exit_station)
    unless calculate_fine(:out)
      @log.end_journey(exit_station)
      deduct(@log.current_journey.calculate_fare)
      ###SET JOURNEY TO BE NIL IN DEDUCTING FAIR METHOD INSTEAD

    end
  end

  def under_limit?
    @balance < MINIMUM_FARE
  end

  private
  def deduct(amount)
    @balance -= amount
    @journey = nil
  end

  def calculate_fine(action)
    case (action)

    when (:in)
      if !@log.current_journey.nil?
        deduct(FINE)
        puts "£6 fine - not touching out"
      end
    when (:out)
      if @log.current_journey.nil?
        deduct(FINE)
        puts "£6 fine - not touching in"
        true
      else
        false
      end
    end
  end
end
