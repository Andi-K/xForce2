extends ReferenceFrame

export(int, "left", "right") var side = 1

func _input_event(ev):
	# FIXME: use Signal mouse_enter()
	if (ev.type==InputEvent.MOUSE_MOTION):
		var ani = get_parent().get_node("Animation")
		if (ani.is_playing()):
			return

		if side == 0:
			# Mouse moved to left
			if (ev.speed_x < 0 and get_parent().outside): 
				ani.play("LeftSlideIn")
				get_parent().outside = false
			# Mouse moved to right
			elif (ev.speed_x > 0 and !get_parent().outside): 
				ani.play("LeftSlideOut")
				get_parent().outside = true
		else:
			# Mouse moved to right
			if (ev.speed_x > 0 and get_parent().outside): 
				ani.play("RightSlideIn")
				get_parent().outside = false
			# Mouse moved to left
			elif (ev.speed_x < 0 and !get_parent().outside): 
				ani.play("RightSlideOut")
				get_parent().outside = true
