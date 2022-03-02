class Journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @complete = false
  end

  def starts(entry_station= nil)
    @entry_station = entry_station
  end

  def finishes(exit_station= nil)
    @exit_station = exit_station
    @complete = true
  end
  
  def fare
    !@entry_station || !exit_station ? PENALTY_FARE : MINIMUM_FARE
  end

  def complete?
    @complete
  end
end