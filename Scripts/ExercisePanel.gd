extends Control

signal selected_item(selected)

var selected
var missing_req = preload("res://Art/MissingRequirementsIcon.png")


func _ready():
	initMissingRequirementsHighlight()


func createPanel(exercise_name : String, muscle_texture, type_texture, exercise):
	
	if exercise_name.match("Blank"):
		return
	
	var proficiency_progress = $VBoxContainer/HBox_Proficiency/ProficiencyProgress
	
	$VBoxContainer/HBoxContainer/Button_Name.set_text(exercise_name)
	$VBoxContainer/HBox_Icons/Texture_Muscle.set_texture(muscle_texture)
	$VBoxContainer/HBox_Icons/Texture_Type.set_texture(type_texture)
	
	proficiency_progress.exercise = exercise
	proficiency_progress.updateProgress(exercise)
	
	getLevelRequirement(exercise)
	
	getEquipmentRequirement(exercise)
	
	var requirement = getEquipmentRequirement(exercise)
	if requirement != null:
		var texture = load("res://Art/SmallIcons/UnitIcon_Small.png")
		$VBoxContainer/HBoxContainer/MenuButton.get_popup().add_icon_item(texture, requirement)
	
	updatePanelMenu(exercise)
	
	selected = exercise


func updatePanelMenu(exercise):
	# Indices for Menu
	# 0 - Money
	# 1 - Time
	# 2 - Strength XP
	# 3 - Proficiency XP
	
	var time = Globals.calculateRepTime(Globals.player.strength_level[exercise.muscle_groups], Globals.player.proficiency_level[exercise.exercise_name], exercise.rep_time)
	var money = Globals.calculateMoneyEarned(Globals.player.proficiency_level[exercise.exercise_name], exercise.rep_time)
	var strength = str(exercise.base_strength)

	$VBoxContainer/HBoxContainer/MenuButton.get_popup().set_item_text(0, money)
	$VBoxContainer/HBoxContainer/MenuButton.get_popup().set_item_text(1, time)
	$VBoxContainer/HBoxContainer/MenuButton.get_popup().set_item_text(2, strength + "xp")
	$VBoxContainer/HBoxContainer/MenuButton.get_popup().set_item_icon(2, Globals.muscle_icons_small[exercise.muscle_groups])


func getLevelRequirement(exercise):
	
	if exercise.has_level_requirement:
		var level
		level = "Level " + str(exercise.level_requirement)
		$VBoxContainer/HBoxContainer/MenuButton.get_popup().add_icon_item(Globals.muscle_icons_small[exercise.muscle_groups], level)
		return level


func getEquipmentRequirement(exercise):
	
	var text = ""
	var unit = exercise.unit_req
	var equipment_1 = exercise.equipment_req_1
	var equipment_2 = exercise.equipment_req_2
	
	if unit != "None":
		text = text + unit
		
		if equipment_1 != "None":
			text = text + ", " + equipment_1
			
			if equipment_2 != "None":
				text = text + ", " + equipment_2
	
	elif equipment_1 != "None":
		text = equipment_1
		
		if equipment_2 != "None":
			text = text + ", " + equipment_2
	
	elif equipment_2 != "None":
		text = equipment_2
	
	else:
		return null
	
	return text


func initMissingRequirementsHighlight():
	
	var texture = TextureRect.new()
	
	texture.set_texture(missing_req)
	texture.set_expand(true)
	texture.set_stretch_mode(1)
	texture.anchor_right = 1
	texture.anchor_bottom = 1
	
	missing_req = texture
	
	$VBoxContainer/HBoxContainer/MenuButton.add_child(missing_req)
	missing_req.hide()


func displayHighlight():
	missing_req.show()
	$Timer_MissingReq.start(1.0)


func _on_Timer_MissingReq_timeout():
	missing_req.hide()


func determineUnlocked(exercise):
	
	var unit = Globals.player.gym_units[exercise.unit_req]
	var equipment_1 = Globals.player.gym_equipment[exercise.equipment_req_1]
	var equipment_2 = Globals.player.gym_equipment[exercise.equipment_req_2]
	var level = Globals.player.strength_level[exercise.muscle_groups] >= exercise.level_requirement
	
	if unit == true and equipment_1 == true and equipment_2 == true and level == true:
		return true
	
	else:
		return false


func _on_Button_Name_pressed():
	
	if determineUnlocked(selected):
		emit_signal("selected_item", selected)
	
	else:
		displayHighlight()



