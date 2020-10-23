require 'journey'

RSpec.describe Journey do
  let(:entry_station) {double("dalston station")}
  let(:exit_station) {double("highgate station")}

  before(:example) do
    @card = Oystercard.new
    @card.top_up(59)
    @card.touch_in(entry_station)
  end

  describe '#touch_in' do
    it 'checks if card in a journey' do
      expect(@card.journey.in_journey).to eq true
    end

    it 'remembers entry station' do
      expect(@card.journey.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it 'check if card is not in a journey' do
      @card.touch_out(exit_station)
      expect(@card.journey.nil?).to eq true
    end

    it 'deducts money from balance' do
      expect{@card.touch_out(exit_station)}.to change{@card.balance}.by(-1)
    end

    it 'saves your list of journeys' do
      @card.touch_out(exit_station)
      expect(@card.all_journeys[0].single_journey).to eq({:start => entry_station, :finish => exit_station})
    end
  end
end
