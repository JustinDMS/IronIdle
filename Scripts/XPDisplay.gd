extends Control


func setXPDisplay(item : String, exercise, muscle):
	
	var xp_to_level = get_node_or_null("Panel/VBoxContainer/HBoxContainer/Label_XPToLevel")
	var current_xp = get_node_or_null("Panel/VBoxContainer/HBoxContainer/Label_CurrentXP")
	var current_total = get_node_or_null("Panel/VBoxContainer/HBoxContainer2/Label_CurrentTotalXP")
	var xp_target
	
	if item == "Strength":
		
		if Globals.player.strength_level[muscle] == 50:
			if is_instance_valid(get_node_or_null("Panel/VBoxContainer/HBoxContainer")):
				$Panel/VBoxContainer/HBoxContainer.queue_free()
		
		else:
			xp_to_level.set_text("XP to level " + str(Globals.player.strength_level[muscle] + 1) + ": ")
			xp_target = Globals.calculateStrengthXPForLevel(Globals.player.strength_level[muscle])
			current_xp.set_text(Globals.formatBigNumber(xp_target - Globals.player.xp[muscle]))
			
		current_total.set_text(Globals.formatBigNumber(Globals.player.xp_total[muscle]))
	
	elif item == "Proficiency":
		
		if Globals.player.proficiency_level[exercise.exercise_name] == 20:
			if is_instance_valid(get_node_or_null("Panel/VBoxContainer/HBoxContainer")):
				$Panel/VBoxContainer/HBoxContainer.queue_free()
		else:
			xp_to_level.set_text("XP to level " + str(Globals.player.proficiency_level[exercise.exercise_name] + 1) + ": ")
			xp_target = Globals.calculateProficiencyXPForLevel(Globals.player.proficiency_level[exercise.exercise_name])
			current_xp.set_text(Globals.formatBigNumber(xp_target - Globals.player.proficiency_xp[exercise.exercise_name]))
		
		current_total.set_text(Globals.formatBigNumber(Globals.player.proficiency_xp_total[exercise.exercise_name]))
