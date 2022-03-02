require 'journeylog'

describe JourneyLog do
  
  it 'takes journey class parameter' do
    testjourney = double(:testjourney)
    log = JourneyLog.new(testjourney)
    expect { log }.to_not raise_error
  end
#subjeclog
  it 'start a journey ' do
    testjourney = double(:testjourney)
    allow(testjourney).to receive(:entry_station).and_return("entry_station")
    log = JourneyLog.new(testjourney)
    expect(log.start("entry_station")).to include("entry_station")
  end

  it 'finish a journey' do
    testjourney = double(:testjourney)
    allow(testjourney).to receive(:exit_station).and_return("exit_station")
    log = JourneyLog.new(testjourney)
    expect(log.finish("exit_station")).to include("exit_station")
  end

  it 'returns a list of all previous journeys' do
    testjourney = double(:testjourney)
    allow(testjourney).to receive(:entry_station).and_return("entry_station")
    allow(testjourney).to receive(:exit_station).and_return("exit_station")
    log = JourneyLog.new(testjourney)
    log.start("entry_station")
    log.finish("exit_station")
    expect(log.journeys).to eq ["entry_station", "exit_station"] 
  end
end

