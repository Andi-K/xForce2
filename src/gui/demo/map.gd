
extends Node2D

const MAX_SPEED = 40.0
const ACCEL=1.0
const VSCALE=1

var speed=Vector2()

var darknes_color = null

func _ready():
	self.set_fixed_process(true)

func _notification(id):
	if (id==NOTIFICATION_VISIBILITY_CHANGED):
		if is_hidden():
			# hide stuff we don't want to see on other pages 
			var darknes = get_node("CanvasModulate")
			darknes_color = darknes.get_color()
			remove_child(darknes)

			get_node("Popup").hide()
			
			get_tree().set_pause(true)
		else:
			# update the scene 
			if darknes_color == null:
				get_tree().set_pause(false)
				return
			get_node("Popup").show()
			var darknes = CanvasModulate.new()
			darknes.set_name("CanvasModulate")
			darknes.set_color(darknes_color)
			add_child(darknes)

			# we need this to active the collision detection
			get_tree().set_pause(false)


func _fixed_process(delta):
	var dir = Vector2()
	if (Input.is_action_pressed("cam_up")):
		dir+=Vector2(0,MAX_SPEED)
	if (Input.is_action_pressed("cam_down")):
		dir+=Vector2(0,-MAX_SPEED)
	if (Input.is_action_pressed("cam_left")):
		dir+=Vector2(MAX_SPEED,0)
	if (Input.is_action_pressed("cam_right")):
		dir+=Vector2(-MAX_SPEED,0)

	#if (dir!=Vector2()):
		#dir=dir.normalized()

	speed = speed.linear_interpolate(dir*MAX_SPEED,delta*ACCEL)
	var motion = speed * delta
	motion.y*=VSCALE
	#get_node("camera").set_pos(get_node("camera").get_pos()+motion)
	self.set_pos(self.get_pos()+motion)

func _on_prince_area_body_enter( body ):
	if (body.get_name()=="cubio"):
		get_node("message").show()


func _on_Area2D_body_enter( body ):
	if (body.get_name()=="cubio"):
		get_node("wall_map/cubio/Light2D").set_enabled(true)


func _on_Area2D_body_exit( body ):
	if (body.get_name()=="cubio"):
		get_node("wall_map/cubio/Light2D").set_enabled(false)

