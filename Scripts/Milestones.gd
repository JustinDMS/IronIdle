extends Control

var muscle_group
var font = load("res://Fonts/SmallText.tres")

func _process(_delta):
	if self.is_visible_in_tree():
		if not Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()): # Has mouse left panel (ignoring child controls)
			hide()


func initMilestoneDisplay(muscle : String):
	muscle_group = muscle
	$Panel/VBoxContainer/Label.set_text(muscle)
	createMilestonesList()


func newLabel(text):
	var label = Label.new()
	label.add_font_override("font", font)
	label.set_align(0)
	label.set_autowrap(true)
	label.set_text(text)
	return label


func addRequirements(exercise):
	
	var text = "\n"
	
	if exercise.unit_req == "None":
		
		if exercise.equipment_req_1 == "None":
			
			if exercise.equipment_req_2 == "None":
				pass
			else:
				text += exercise.equipment_req_2
				text += "\n"
			
		else:
			
			text += exercise.equipment_req_1
			if exercise.equipment_req_2 == "None":
				text += "\n"
			else:
				text += ", " + exercise.equipment_req_2
				text += "\n"
			
	else:
		
		text += exercise.unit_req
		if exercise.equipment_req_1 == "None":
			
			if exercise.equipment_req_2 == "None":
				text += "\n"
			else:
				text += ", " + exercise.equipment_req_2
				text += "\n"
			
		else:
			
			text += ", " + exercise.equipment_req_1
			if exercise.equipment_req_2 == "None":
				text += "\n"
			else:
				text += ", " + exercise.equipment_req_2
				text += "\n"
	
	return text


func createMilestonesList():
	
	for n in $Panel/VBoxContainer/MarginContainer/VBoxContainer_Reqs.get_children():
		n.queue_free()
	
	for i in Globals.all_exercises:
		if i.muscle_groups.match(muscle_group) and i.has_level_requirement:
			var req_text = "Level " + str(i.level_requirement) + " - " + i.exercise_name
			req_text += addRequirements(i)
			$Panel/VBoxContainer/MarginContainer/VBoxContainer_Reqs.add_child(newLabel(req_text))
