# base class for xforce bases

extends "ufopedia.gd"
const type = "FACI"
export var size = [[1, 1]] # [[level0_x, level0_y], [level1_x, level1_y]]
export var surface_only = false
export var bulidtime = 240 # h

export var hitpoints = 1000
export var buildcost = 0 # * 1000 Credits, 0 = not buildable
export var images = []

func _init(values).(values):
	self.require.append("buildcost")
	update_properties(values)
	
	add_detail("SIZE", str(size_x) + " * " + str(size_y))
	if buildcost > 0:
		add_detail("buildcost", str(buildcost * 1000) + " " + tr("CREDITS"))
	else:
		add_detail("buildcost", tr("NOT_BUILDABLE"))
	add_detail("MAXLEVELS", levelbuildcost.size() + 1)

	
	