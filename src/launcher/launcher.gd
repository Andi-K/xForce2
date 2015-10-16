# X-Force 2 launcher

extends Control

var path_exe = OS.get_executable_path()
var path_engine = path_exe.get_base_dir() + "/engine" 

var user = "Dummy"

func _init():
	OS.set_low_processor_usage_mode(true)

func _ready():
	get_node("Player/OptionButton").add_item(user)
	get_node("Gameset/OptionButton").add_item("Demo")
	var user_dir = "player_"+ get_safe_file_name(user)
	var dir = Directory.new()
	dir.open("user://")
	if not dir.dir_exists(user_dir):
		dir.make_dir(user_dir)


func _on_LaunchGame_pressed():
#	don't works well
#	var pack = OS.get_executable_path().get_base_dir() + "/xforce.pck" 
#	if Globals.load_resource_pack(pack):
#		print(Globals.get("application/version"))
#		get_tree().change_scene("res://game.xscn")
#	else:
#		printerr("Can't load '"+ pack +"'")
	var args = StringArray(["-path", path_engine])
	var out = []
	if OS.execute(path_exe, args, true, out):
		var file = File.new()
		var file_name = "user://"+ get_safe_file_name(user) +"/engine.log"
		var error = file.open(file_name, File.WRITE)
		if (file.is_open()):
			var out_str = ""
			for line in out:
				out_str += line +"\n"
			file.store_string(out_str)
			file.close()
		else:
			print("Unable to create log file '"+ file_name +"'!")
	else:
		printerr("Can't tun engine")
		

func get_safe_file_name(name, limit = 5):
	var file_name = ""
	name = name.strip_edges().to_lower()
	
	var regex = RegEx.new()
	regex.compile("\\w+") # ASCII Words
	regex.find(name)
	var captures = regex.get_captures()
	while captures[0] != "" and limit > 0:
		file_name += "_"+ captures[0]
		name = name.replace(captures[0], "").strip_edges()
		regex.find(name)
		captures = regex.get_captures()
		limit -= 1
	
	return file_name.right(1)