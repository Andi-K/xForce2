# base class for all game (set) objects
#
# please don't use it dirctly
# ``add()`` take care about 

extends Resource
# extends Node # needed for get_node(/root/Data)
const type = "OBJECT"
export(String)	var category = "" # category / group
export(int)		var id = 0 setget set_id
# export(String)	var id_name = "" # short ID for scrips (optional) TODO: do we need it?
export(bool)	var active = true
var id_str = "" setget set_id , get_id_str # auto generated 

var require = ["id"]
var updated = false


#func array_pop(arr):
#	var r = arr[arr.size() -1]
#	arr.remove(arr.size() -1)
#	return r

func get_export_vars():
	# TODO: find a more safe way to get export vars and may extend Resource instad Node
	var export_vars = []
	var properties = get_property_list()
	for p in properties:
		if p.usage == 7:
			export_vars.append(p.name)
	return export_vars

func update_properties(from):
	if self.updated:
		return
	var properties = get_export_vars()
	self.updated = true

	for p in properties:
		if from.has(p):
			self[p] = from[p]
		else:
			if require.find(p) >= 0:
				printerr("ERR: missing value '"+ p +"', got: '" + str(from) +"'")
				id = -1 # => invald id as error code
				return false

func _init(values):
	update_properties(values)

func as_dict():
	var dic = {"TYPE": self.type}
	for property in get_export_vars():
		dic[property] = self[property]
	return dic


func set_id(nid):
#	if id > 0:
#		printerr("don't change a ID!")
#		pass
#	else:
#		id = nid
		pass
	
func get_id_str():
	return self.type +"_"+ self.category +"_"+ str(id)

