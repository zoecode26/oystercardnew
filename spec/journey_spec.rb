require 'journey'

RSpec.describe Journey do
  let(:entry_station) {double(:name => "dalston station", :zone => 5)}
  let(:exit_station) {double(:name => "highgate station", :zone => 1)}

  before(:example) do
    @card = Oystercard.new
    @card.top_up(59)
    @card.touch_in(entry_station)
  end

  describe '#touch_in' do
    it 'checks if card in a journey' do
      expect(@card.log.in_journey).to eq true
    end

    it 'remembers entry station' do
      expect(@card.log.current_journey.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it 'check if card is not in a journey' do
      @card.touch_out(exit_station)
      expect(@card.journey.nil?).to eq true
    end

    it 'saves your list of journeys' do
      @card.touch_out(exit_station)
      expect(@card.log.all_journeys[0].single_journey).to eq({:start => entry_station, :finish => exit_station})
    end

    it 'calculates the fare' do
      allow(entry_station).to receive(:zone).and_return(5)
      allow(exit_station).to receive(:zone).and_return(1)
      expect{@card.touch_out(exit_station)}.to change{@card.balance}.by(-5)
    end
  end
end
