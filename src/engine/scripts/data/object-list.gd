extends Resource
# extends Node

var highes_id = 0
var id_str = {} # map ID_str => ID
var id = {} # map ID => object
# var name = {} # map ID_name => ID_str
var active = [] # list of all active Objects
var inactive = []

var object_types = {
	OBJECT = preload("res://scripts/data/object.gd"), # very basic Object
	BASE   = preload("res://scripts/data/base.gd"), # X-Force Base
	STORY  = preload("res://scripts/data/ufopedia.gd"), # Basic UFOpedia object (STORY entry)
	STORE  = preload("res://scripts/data/store.gd"), # big raw materials
	CARRY  = preload("res://scripts/data/carry.gd"), # raw materials you can find in a ground combat 
}

	 # Basic Reserch (Technology)

func _init(dic):
	for object in dic:
		add(dic[object].TYPE, dic[object])

func add(cat, values):
	# take care about the IDs
	if values.has("id"):
		if values["id"] < 1:
			values["id"] = highes_id + 1
		else:
			if id.has(values["id"]):
				printerr("ERR: dublicate ID! " + str(values["id"]))
				printerr("ID changed!")
				values["id"] = highes_id + 1
	else:
		values["id"] = highes_id + 1
	
	var entry = (object_types[cat]).new(values)

	if not entry extends (object_types["OBJECT"]) or entry.id < 1: # something went wrong
		printerr("entry not added")
		return false

	if entry.id > highes_id:
		highes_id = entry.id

	if (entry.active):
		active.append(entry.id_str)
	else:
		inactive.append(entry.id_str)
	
	id_str[entry.id_str] = entry
	id[entry.id] = entry.id_str
	
#	if values.has("id_name"):
#		name[entry.id_name] = entry.id_str
		
	return entry.id_str

func as_dict():
	var dic = {}
	
	for object in id_str:
		var object_dict = id_str[object].as_dict()
		var keys = {}
		for key in object_dict:
			keys[key] = object_dict[key]
		dic[object] = keys
		
	return dic