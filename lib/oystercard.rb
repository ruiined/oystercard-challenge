require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class OysterCard
  attr_reader :balance

  LIMIT = 90

  def initialize(journey_log: JourneyLog)
    @journey_log = journey_log.new
    @balance = 0
  end

  def top_up(amount)
    limit_error(amount)
    @balance += amount
  end

  def touch_in(entry_station, zone)
    insufficient_balance_error
    station = Station.new(entry_station, zone)
    @journey_log.start(station)
  end

  def touch_out(exit_station, zone)
    station = Station.new(exit_station, zone)
    deduct(@journey_log.to_charge)
    @journey_log.finish(station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def limit_error(amount)
    raise "Balance exceeds the limit of £#{LIMIT}" if @balance + amount >= LIMIT
  end

  def insufficient_balance_error
    raise "The balance is insufficient. Minimum amount of £#{Journey::MINIMUM_FARE} required." if @balance < Journey::MINIMUM_FARE
  end
end