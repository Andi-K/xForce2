# base class for objects you can store in a base

extends "ufopedia.gd"
const type = "STORE"
export(float) var storage = 1.0 # space used
export(int) var packet_size = 1 # amunition
export(int) var buy = 0 # price in Credits, 0 = you can't buy it 
export(int) var sell = 0 # price in Credits, 0 = you can't sell it
export(Dictionary) var disassenble = {} # into; "Credits" | "Alphatron" | object_id_str : amount;  

func _init(values).(values):
#	self.require.append("")
	update_properties(values)

	add_detail("storage")
	if packet_size > 1:
		add_detail("packet_size")
	else:
		add_detail("packet_size", null)
	if buy > 1:
		add_detail("buy")
	else:
		add_detail("buy", tr("NOT_BUYABLE"))
	if sell > 1:
		add_detail("sell")
	else:
		add_detail("sell", tr("NOT_SELLABLE"))
	
	if disassenble.empty():
		add_detail("disassenble", tr("NOT_RECYCELABLE"))
	else:
		var trans = {}
		for into in disassenble:
			trans[tr(into +"_NAME")] = str(disassenble[into])
		add_detail("disassenble", trans)

	