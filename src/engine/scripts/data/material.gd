# base class for xforce bases

extends "ufopedia.gd"
const type = "MAT"
export(float) var storage = 1.0 # 0 = virtual/global like Credits
export(float) var weigh = 1.0 # kg
export(int) var packet_size = 1 # amunition
export(int) var buy = 0 # price in Credits, 0 = you can't buy it 
export(int) var sell = 0 # price in Credits, 0 = you can't sell it
export(Dictionary) var disassenble = {} # into; "Credits" | "Alphatron" | object_id_str : amount;  
export(int) var max_hp = 100 
# sprite for groundcombat?

var details_order = ["STORAGE", "WEIGH", "PACKET_SIZE", "BUY", "SELL", "DISASSENBLE"]
var details = {}

func _init(values).(values):
#	self.require.append("")
	update_properties(values)

	details["STORAGE"] = storage
	details["WEIGH"] = weigh
	details["DISASSENBLE"] = disassenble
	
	if packet_size > 1:
		details["PACKET_SIZE"] = packet_size
	else:
		details["PACKET_SIZE"] = null
	if buy > 1:
		details["BUY"] = buy
	else:
		details["BUY"] = tr("NOT_BUYABLE")
	if sell > 1:
		details["SELL"] = sell
	else:
		details["SELL"] = tr("NOT_SELLABLE")
	