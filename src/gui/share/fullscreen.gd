
extends CheckBox

func _ready():
	if (get_node("/root/Data").config["fullscreen"]):
		OS.set_window_fullscreen(true)
		set_pressed(OS.is_window_fullscreen())

	self.connect("pressed", self, "_on_pressed")

func _on_pressed():
	OS.set_window_fullscreen(self.is_pressed())
