require 'journey'

describe Journey do
  let(:journey) { Journey.new }
  
  it 'starts a journey' do
    journey.starts("Aldgate")
    expect(journey.entry_station).to include("Aldgate")
  end

  it 'finishes a journey' do
    journey.finishes("Bank")
    expect(journey.exit_station).to include("Bank")
  end

  it 'does not complete a journey if there is no touch out' do
    journey.starts("Aldgate")
    expect(journey).to_not be_complete
  end

  it "completes a journey if there is a touch out" do
    journey.starts("Aldgate")
    journey.finishes("Bank")
    expect(journey).to be_complete
  end

  it 'calculates a correct fare of a journey' do
    journey.starts("Aldgate")
    journey.finishes("Bank")
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'calculates a penalty charge if there is no touch in' do
    journey.finishes("Bank")
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'calculates a penalty charge if there is no touch out' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns whether the journey is complete' do
    expect(journey.complete?).to be false
  end
end