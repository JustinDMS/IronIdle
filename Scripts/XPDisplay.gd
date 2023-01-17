extends Control


func setXPDisplay(item : String, exercise, muscle):
	
	var xp_to_level = $Panel/VBoxContainer/HBoxContainer/Label_XPToLevel
	var current_xp = $Panel/VBoxContainer/HBoxContainer/Label_CurrentXP
	var current_total = $Panel/VBoxContainer/HBoxContainer2/Label_CurrentTotalXP
	var xp_target
	
	if item == "Strength":
		xp_target = Globals.calculateStrengthXPForLevel(Globals.player.strength_level[muscle])
		xp_to_level.set_text("XP to level " + str(Globals.player.strength_level[muscle] + 1) + ": ")
		current_xp.set_text(str(xp_target - Globals.player.xp[muscle]))
		current_total.set_text(str(Globals.player.xp_total[muscle]))
	
	elif item == "Proficiency":
		
		xp_target = Globals.calculateProficiencyXPForLevel(Globals.player.proficiency_level[exercise.exercise_name])
		xp_to_level.set_text("XP to level " + str(Globals.player.proficiency_level[exercise.exercise_name] + 1) + ": ")
		current_xp.set_text(str(xp_target - Globals.player.proficiency_xp[exercise.exercise_name]))
		current_total.set_text(str(Globals.player.proficiency_xp_total[exercise.exercise_name]))

