
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("AcceptDialog").set_exclusive(true)
	get_node("AcceptDialog").popup()

