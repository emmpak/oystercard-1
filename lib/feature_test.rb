require './lib/oystercard'
card = Oystercard.new
card.top_up(30)
station1 = Station.new("Aldgate", 1)
station2 = Station.new("Londong Bridge", 5)
card.touch_in(station1)
card.touch_out(station2)
