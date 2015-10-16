
extends Control

func _ready():
	var data = get_tree().get_root().get_node("/root/Data")
	for scene in data.pages:
		# preload at runetime
		var page = load("res://gui/" + scene + "/" + scene + ".xscn").instance()
		page.set_name(scene)
		
		page.set_pause_mode(PAUSE_MODE_STOP)

		self.add_child(page)
		page.hide()
	

	if (data.config["play_intro"]):
		get_tree().set_pause(false)
		var intro = load("res://scenes/intro/into.xscn").instance()
		intro.set_pause_mode(PAUSE_MODE_PROCESS)
		var node = get_node("/root/Game/Scene")
		node.add_child(intro)
	else:
		on_start(null)

func on_start(delete_scene):
	get_tree().set_pause(true)
	# TODO: let gamesets start with another page
	self.get_node("geoscape").show()
	self.get_node("geoscape").set_pause_mode(PAUSE_MODE_PROCESS)
	self.get_node("/root/Game/GUI").set_pause_mode(PAUSE_MODE_PROCESS)
	self.get_node("/root/Game/GUI").show()
	if (delete_scene != null):
		var node = get_node("/root/Game/Scene/"+ delete_scene)
		node.queue_free()
	
