require 'journey'

class JourneyLog

    def initialize(journey= Journey.new)
        @journey = journey
        @journey_history = []
    
    end
    
    def start(entry_station)
        @journey_history << @journey.entry_station
    end

    private

    def current_journey
        @journey.complete? ? @journey : @journey_history[0]

    end
end