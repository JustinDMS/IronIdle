extends Control


func _ready():
	
	var scene = load("res://Scenes/InventoryItem.tscn")
	
	for i in Globals.player.gym_equipment:
		var instance = scene.instance()
		addInventoryItem(instance, i, Globals.player.gym_equipment, $Panel/VBoxContainer/HBoxContainer/VBox_Equipment/GridContainer)
	
	for i in Globals.player.gym_units:
		var instance = scene.instance()
		addInventoryItem(instance, i, Globals.player.gym_units, $Panel/VBoxContainer/HBoxContainer/VBox_Units/MarginContainer/GridContainer)


func addInventoryItem(instance, item, array, container):
	
	if item == "None":
		return
	
	else:
		instance.addItem(item, array)
		container.add_child(instance)


func _input(event):
	if event.is_action_pressed("right_click"):
		queue_free()


func _on_Panel_mouse_exited():
	if not Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()): # Has mouse left panel (ignoring child controls)
		queue_free()
