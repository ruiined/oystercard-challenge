require 'journey'

describe Journey do
  let(:journey) { Journey.new(starting_station) }
  let(:starting_station) { double name: "Aldgate", zone: 1 }
  let(:finishing_station) { double name: "Bank", zone: 3 }
  
  it 'starts a journey' do
    expect(journey.entry_station.name).to include(starting_station.name)
  end

  it 'finishes a journey' do
    journey.finishes(finishing_station)
    expect(journey.exit_station.name).to include(finishing_station.name)
  end

  it 'does not complete a journey if there is no touch out' do
    expect(journey).to_not be_complete
  end

  it "completes a journey if there is a touch out" do
    journey.finishes(finishing_station)
    expect(journey).to be_complete
  end

  it 'calculates a correct fare of a journey' do
    journey.finishes(finishing_station)
    expect(journey.fare).to eq 3
  end

  it 'calculates a penalty charge if there is no touch in' do
    not_started_journey = Journey.new
    not_started_journey.finishes(finishing_station)
    expect(not_started_journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'calculates a penalty charge if there is no touch out' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns whether the journey is complete' do
    expect(journey.complete?).to be false
  end
end