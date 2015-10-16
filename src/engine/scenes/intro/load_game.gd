
extends Button

func _pressed():
	var node = get_node("/root/Game")
	node.exit_scene()
