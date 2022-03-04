require 'journey_log'

describe JourneyLog do  
  let(:journey_log) { JourneyLog.new }
  let(:journey) { double :journey, entry_station: "entry station", exit_station: "exit station" }

  it 'takes journey class parameter' do
    expect { journey_log }.to_not raise_error
  end

  it 'starts a journey ' do
    expect(journey_log.start("entry station")).to include("entry station")
  end

  it 'finishes a journey' do
    expect(journey_log.finish("exit station")).to include("exit station")
  end

  it 'returns a list of all previous journeys' do
    journey_log.start("entry station")
    journey_log.finish("exit station")
    expect(journey_log.journeys).to eq ["entry station", "exit station"] 
  end
end