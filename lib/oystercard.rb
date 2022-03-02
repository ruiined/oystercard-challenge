require 'journey'

class OysterCard
  attr_reader :balance, :entry_station, :journeys

  LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    limit_error(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    insufficient_balance_error
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(@journey.fare)
    add_journey(exit_station)
  end

  def in_journey?
    !!@entry_station
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

  def add_journey(exit_station)
    @journeys << { @entry_station => exit_station }
  end
end