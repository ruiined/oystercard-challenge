require_relative 'journey'

class JourneyLog
    def initialize(journey_class = Journey)
        @journey_class = journey_class
        @journeys = []
    end
    
    def start(station)
        @journeys << @journey_class.new(station)
    end

    def finish(station)
        @journeys << current_journey.finishes(station)
    end

    def journeys
        @journeys.clone
    end

    def to_charge
        # @journeys.last.complete? == false ? @journeys.last.fare : 0
        @journeys.last.complete? ? 0 : current_journey.fare
    end

    private

    def current_journey
        @journeys.last.complete? ? @journey_class.new : @journeys.last
    end
end