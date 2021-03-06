require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def finishes(exit_station = nil)
    @complete = true
    @exit_station = exit_station
  end
  
  def fare
    @entry_station == nil || @exit_station == nil ? PENALTY_FARE : zones
  end

  def zones
    (@entry_station.zone - @exit_station.zone).abs + 1
  end

  def complete?
    @complete
  end
end