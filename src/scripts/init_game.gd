extends Node

var gui_pages = {}
var curent_page_node = null

func _ready():
	var data = get_node("/root/Data")

	data.curent["resolution"] = "FHD"
	
	if (data.config["play_intro"]):
		play_scene("res://scenes/intro/FHD.xscn")

	# preload gui pages at runetime
	for page in data.pages:
		# TODO: let gamesets load other pages
		gui_pages[page] = load("res://gui/" + page + "/" + data.curent["resolution"] + ".xscn")

	if (data.config["play_intro"]):
		load_page(data.curent["page"], true)
	else:
		load_page(data.curent["page"])
		get_node("GUI").show()
		# We can save CPU Power if we start the game paused and set the curent page to process alltime
		# Some Things (animated light, collision detection) don't work in pause mode but gui pages don't need them (or?)
		get_tree().set_pause(true)
		
	var gs_node = Node.new()
	gs_node.set_name("Gameset") 
	gs_node.set_script(data.load_res("gs://src/gameset.gd"))
	add_child(gs_node)

func load_page(page, paused = false):
	var new_page = gui_pages[page].instance()
	new_page.set_name(page)
	if paused:
		new_page.set_pause_mode(PAUSE_MODE_STOP)
		new_page.hide()
		get_node("GUI").set_pause_mode(PAUSE_MODE_STOP)
		get_node("GUI").hide()
	else:
		new_page.set_pause_mode(PAUSE_MODE_PROCESS)
		get_node("GUI").show()
		get_node("GUI").set_pause_mode(PAUSE_MODE_PROCESS)

	if curent_page_node != null:
		curent_page_node.hide()
		curent_page_node.queue_free()

	get_node("Page").add_child(new_page)
	curent_page_node = get_node("Page/" + page)
	get_node("/root/Data").curent["page"] = page

func play_scene(scene, hide_gui = true):
	get_tree().set_pause(false)
	var new_scene = load(scene).instance()
	new_scene.set_name("Scene")
	if (curent_page_node != null):
		curent_page_node.set_pause_mode(PAUSE_MODE_STOP)
		curent_page_node.hide()
	if hide_gui:
		get_node("GUI").set_pause_mode(PAUSE_MODE_STOP)
		get_node("GUI").hide()
	add_child(new_scene)

func exit_scene():
	get_tree().set_pause(true)
	curent_page_node.show()
	curent_page_node.set_pause_mode(PAUSE_MODE_PROCESS)
	get_node("GUI").show()
	get_node("GUI").set_pause_mode(PAUSE_MODE_PROCESS)
	get_node("Scene").queue_free()
	

