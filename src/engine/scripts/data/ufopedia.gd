# base class for all objects whit ufopedia entry

extends "object.gd"
const type = "STORY"
export(String, FILE)	var image = ""
export(String, FILE)	var icon = ""
export(bool)			var hiden = false
var name setget , get_object_name
var description setget , get_desc

var details_order = []
var details = {}

var hf = preload("res://scripts/helper_func.gd")

func _init(values).(values):
	update_properties(values)

func get_object_name(): # get_name() is used by Node
	return tr(self.id_str + "_NAME")

func get_desc():
	return tr(self.id_str + "_DESC").replace("\\n", "\n")

func add_detail(key, value = "KEY"):
	details_order.append(key.to_upper())
	if str(value) != "KEY":
		details[key.to_upper()] = value
	else:
		if typeof(self[key]) == TYPE_REAL: # Float
			details[key.to_upper()] = hf.ntr(self[key], 2)
		elif typeof(self[key]) == TYPE_INT:
			details[key.to_upper()] = hf.ntr(self[key], 0)
		else:
			details[key.to_upper()] = self[key]
	