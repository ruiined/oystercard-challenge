require_relative 'journey'

class JourneyLog
    def initialize(journey = Journey)
        @journey = journey
        @journeys = []
    end
    
    def start(station)
        @journeys << @journey.new(entry_station = station)
    end

    def finish(station)
        @journeys << @journeys.last.finishes(exit_station = station)
    end

    def journeys
        @journeys.clone
    end

    def to_charge
        @journeys.last.complete? == false ? @journeys.last.fare : 0
    end

    #private

    def current_journey
        @journeys.last.complete? ? @journeys.last : @journeys[0]
    end
end