
extends TextureFrame

func _ready():
	#var game = get_node("/root/Game/Data").game
	var gameset = get_node("/root/Data").gameset
	# set_text(game["name"])
	get_node("Gameset").set_text(gameset["name"] + "\n" + Globals.get("application/version") + " (" + gameset["version"] + ")")

