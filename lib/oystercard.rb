require_relative 'journey'
require_relative 'journey_log'

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

  def touch_in(entry_station)
    insufficient_balance_error
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(@journey_log.to_charge)
    @journey_log.finish(exit_station)
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