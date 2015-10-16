extends Control

var player

func change_volume(vol):
	if vol == 0:
		get_node("Mute").set_pressed(true)
	player.set_volume(vol)

func stop_player(pressed):
	if  pressed:
		player.stop()
	else:
		player.play()

func _ready():
	var data = get_node("/root/Data")
	get_node("Volume").connect("value_changed", self, "change_volume")
	get_node("Mute").connect("toggled", self, "stop_player")
	player = get_node("../../Audio/StreamPlayer")
	get_node("Mute").set_pressed(data.config["mute"])
	get_node("Volume").set_value(data.config["volume"])
	change_volume(data.config["volume"])
