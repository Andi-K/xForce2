extends Control

# TODO: replace by PopupMenu? hover =>  mouse_enter()

# Buttons are outside the viewport 
var outside = true
#export(int, "left", "right") var side = 1
#export(bool) var fixed = true
#export(Color, RGBA) var color = [30, 30, 30, 0.8]

# button name = page / scene name
var buttons = StringArray(["geoscape", "ufopedia", 
		"seperator", "demo", "poc"])
		# = "Bases",
		# = "Fleet",
		# = "Combat Units",
		# seperator = "",
		# = "Research",
		# = "Production",
		# = "Storage",
		# = "Job market",
		# seperator = "",
		# = "Base information",
		# = "Countries",
		# = "Finanzes",
		#poc = "PoC GorndBattel",

func _ready():
	var pages = get_node("/root/Data").pages
	var curent_page = get_node("/root/Data").curent["page"]
	
	var node = get_node("Buttons")
	
	for button in buttons:
		if (button == "seperator"):
			var sep =  HSeparator.new()
			node.add_child(sep)
		else:
			if pages.has(button):
				var btn = Button.new()
				btn.set_name(button)
				btn.set_text(pages[button]["name"])
				btn.connect("pressed", self, "_button_pressed", [button])
				btn.set_disabled(button == curent_page)
				node.add_child(btn)
			else:
				print("Sidebar: invalid item '"+ button + "'")
				# buttons.erase(button)
	
	get_node("HoverArrea").hide()
	if outside:
		get_node("Animation").play("RightSlideIn")
	outside = false

		
func _button_pressed(scene):
	get_node("/root/Game").load_page(scene)
	update()

func update():
	var pages = get_node("/root/Data").pages
	var curent_page = get_node("/root/Data").curent["page"]
	
	for button in buttons:
		if (button != "seperator"):
			var btn = get_node("Buttons/" + button)
			if (btn != null):
				btn.set_disabled(button == curent_page)

	if pages[curent_page]["sidebar"] == 2: # fixed
		get_node("HoverArrea").hide()
		if outside:
			get_node("Animation").play("RightSlideIn")
		outside = false
	elif pages[curent_page]["sidebar"] == 1: # hover
		get_node("HoverArrea").show()
		if !outside:
			get_node("Animation").play("RightSlideOut")
		outside = true
	else: # no sidebar
		hide()
