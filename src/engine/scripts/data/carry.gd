# base class for objects you can carry in a ground combat

extends "store.gd"
const type = "CARRY"
export(float) var weigh = 1.0 # kg
export(int) var max_hp = 100 
# sprite for groundcombat

func _init(values).(values):
	update_properties(values)

	add_detail("weigh")
