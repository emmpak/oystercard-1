require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :station, zone: 1 }
  let(:exit_station) { double :station, zone: 3 }
  let(:journey) {double :journey}

  describe "#initialze" do
    it "has balance of zero" do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it "adds to balance" do
      expect{ oystercard.top_up 20}.to change{ oystercard.balance }.by 20
    end

    it "raises error if limit exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up 1 }.to raise_error "Top up unsuccessful: Balance cannot exceed £#{maximum_balance}."
    end
  end

  describe "#touch_in" do
    it "raises error if below minimum balance" do
      expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds: Please top-up."
    end

    it "calls the add_trip method on log when in_journey" do
      oystercard.top_up(50)
      allow(oystercard).to receive(:in_journey?) {true}
      expect(oystercard.log).to receive(:add_trip)
      oystercard.touch_in(entry_station)
    end
  end

  describe "touch_out" do
    before do
      oystercard.top_up(50)
      oystercard.touch_in(entry_station)
    end

    it "calls the finish method on journey" do
      expect(oystercard.journey).to receive(:finish).with(entry_station)
      allow(oystercard.journey).to receive(:amount) {2}
      oystercard.touch_out(entry_station)
    end

    it "calls the add_trip method on log" do
      expect(oystercard.log).to receive(:add_trip)
      oystercard.touch_out(entry_station)
    end

    it "calls the add_trip method on log when not in_journey" do
      oystercard.touch_out(entry_station)
      expect(oystercard.log).to receive(:add_trip)
      oystercard.touch_out(entry_station)
    end
  end

  context "#journey fare" do
    before do
      oystercard.top_up(50)
    end

    it "expects penalty charge after two consecutive touch_ins" do
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it "expects penalty charge after touch_out without touch_in" do
      expect{oystercard.touch_out(entry_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it "expects a touch_out and touch_in to charge minimum fare" do
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(entry_station)}.to change{oystercard.balance}.by -Oystercard::MINIMUM_CHARGE
    end

  end
end
