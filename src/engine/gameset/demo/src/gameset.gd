extends Node

# /root/Data is the most importent node
# it stores all game data and some usefull functions 
# we will use "data" as shortcut for get_node("/root/Data")
var data = Node

func _ready():
	data = get_node("/root/Data")
	
	var date = OS.get_date()
	var object_id
	
	# get_node("/root/Data").objects is a list of all game objetcs
	var objects = data.objects
	# the game will load Objects from "gs://objects.dat"
	# It's easier to edit the objects.dat but we can add Objects at runtime:
	object_id = objects.add("STORY", {"image":"gs://res/Mond150.png", "icon":"gs://res/Mond32.png"})
	# and the translatins for this Object:
	data.add_trans({
		en = {
			_NAME = "Added at Runtime...",
			_DESC = "ID: [i]"+ object_id +"[/i]\\nDate: [b]"+ str(date.year) +"-"+ str(date.month) +"-"+ str(date.day) \
				+"[/b]\\nYour OS: [i][b]"+ OS.get_name() +"[/b][/i]\\n" \
				+"Config file saved at: [i][url]file://"+ OS.get_data_dir() +"/game.cfg[/url][/i]" \
				+"\\n[url=https://github.com/Andi-K/xForce2/blob/master/src/gameset/demo/objects.dat]objects.dat at  GitHub[/url]" \
				+"\\n[url=https://github.com/Andi-K/xForce2/blob/master/src/gameset/demo/src/gameset.gd]Gameset Script at GitHub[/url]",
		}
	}, object_id)
	
	# And save it as text file:
	# WARNING: this owerwites existing files!
	# gs:// = save into the current gameset 
	# user:// = save into user's home dir (configs) 
#	data.save_cfg(objects.as_dict(), "gs://objects_tmp.dat")

	# the objects.dat don't include translatable Text!
	# We have to create new translations files (*.csv)
	# Don't forget to edit and (re)import them!
#	for lang in ["en"]:
#		data.save_tr_str_gs(lang, "gs://src/new_translation")
