require 'journey_log'

RSpec.describe JourneyLog do
  describe '#initialize' do
    it 'contains an empty array' do
      expect(subject.all_journeys).to eq([])
    end
  end
end
