# base class for xforce bases

extends "ufopedia.gd"
const type = "BASE"
export var size_x = 10
export var size_y = 10
export var levelbuildcost = [0, 250, 500, 750, 1000, 1250, 1500] # * 1000 Credits = price to develop base lavel x; 0 = Level developed; Arrysize = max level
export var buildcost = 0 # * 1000 Credits, 0 = not buildable
# export var script = ""
# export var script_args = {}

func _init(values).(values):
	self.require.append("buildcost")
	update_properties(values)

	add_detail("SIZE", str(size_x) + " * " + str(size_y))
	if buildcost > 0:
		add_detail("buildcost", hf.ntr(buildcost * 1000) + " " + tr("CREDITS"))
	else:
		add_detail("buildcost", tr("NOT_BUILDABLE"))
	add_detail("MAXLEVELS", levelbuildcost.size() + 1)

	
	