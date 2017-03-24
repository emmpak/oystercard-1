require './lib/oystercard'
card = Oystercard.new
card.top_up(30)
bank = Station.new("Bank")
arch = Station.new("Archway")
card.touch_in(bank)
card.touch_out(arch)
