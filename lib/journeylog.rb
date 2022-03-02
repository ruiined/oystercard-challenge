require 'journey'

class JourneyLog

    def initialize(journey= Journey.new)
        @journey = journey
        @journeys = []
    end
    
    def start(entry_station)
        @journeys << @journey.entry_station
    end

    def finish(exit_station)
        @journeys << @journey.exit_station
    end

    def journeys
        @journeys.clone
    end
    private

    def current_journey
        @journey.complete? ? @journey : @journeys[0]

    end
end