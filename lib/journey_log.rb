require_relative 'journey'

class JourneyLog
    def initialize(journey: Journey)
        @journey = journey
        @journeys = []
    end
    
    def start(station)
        @journeys << @journey.new(entry_station = station)
    end

    def finish(station)
        @journeys << @journey.finishes(station)
    end

    def journeys
        @journeys.clone
    end

    def to_charge
        @journey.complete? == false ? @journey.fare : 0
    end

    #private

    def current_journey
        @journey.complete? ? @journey : @journeys[0]
    end
end