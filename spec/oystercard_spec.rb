require 'oystercard'

describe OysterCard do
  let(:oystercard) { OysterCard.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) {double :journey, fare: 1, complete?: true}

  it 'has a balance of 0 by default' do
    expect(oystercard.balance).to eq 0
  end

  it 'tops up the balance' do
    oystercard.top_up(20)
    expect(oystercard.balance).to eq 20
  end

  it 'does not allow the balance to exceed the limit' do
    message = "Balance exceeds the limit of £#{OysterCard::LIMIT}"
    expect { oystercard.top_up(100) }.to raise_error(message)
  end

  it 'does not let to touch_in if there is insufficient balance' do 
    message = "The balance is insufficient. Minimum amount of £#{Journey::MINIMUM_FARE} required."
    expect { oystercard.touch_in(entry_station) }.to raise_error(message)
  end

  it 'deducts the correct amount when touching out' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-Journey::PENALTY_FARE)
  end

  it "touch_out takes exit_station argument" do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    expect(oystercard.touch_out(exit_station)).to_not be nil
  end
end

