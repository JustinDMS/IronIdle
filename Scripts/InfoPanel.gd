extends Control



func _on_Button_pressed():
	OS.shell_open("https://github.com/JustinDMS/IronIdle-Releases/issues")
	queue_free()


func _on_Panel_mouse_exited():
	if not Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()): # Has mouse left panel (ignoring child controls)
		queue_free()
