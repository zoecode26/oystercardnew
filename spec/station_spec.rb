
require 'station'

RSpec.describe Station do
 describe '#initialize' do
   it "sets the name property of the station" do
     station = Station.new('Uxbridge', 3)
     expect(station.name).to eq('Uxbridge')
   end

   it "sets the zone property of the station" do
     station = Station.new('Uxbridge', 3)
     expect(station.zone).to eq(3)
   end
 end
end
