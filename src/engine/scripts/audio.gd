extends Node

func _ready():
	var data = get_node("/root/Data")
	
	change_volume(data.config["volume"])
	if not data.config["mute"] and data.config["volume"] > 0:
		get_node("StreamPlayer").play()

func change_volume(vol):
	if vol == 0:
		get_node("StreamPlayer").player.stop()
#	AudioServer.set_fx_global_volume_scale(1)
#	AudioServer.set_event_voice_global_volume_scale(1)
	AudioServer.set_stream_global_volume_scale(vol)
