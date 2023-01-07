extends Control

func setLabels(muscle):
	$Panel/VBoxContainer/HBoxContainer/Label_CurrentXP.set_text(str(Globals.calculateStrengthXPForLevel(Globals.player.strength_level[muscle]) - Globals.player.xp[muscle]))
	$Panel/VBoxContainer/HBoxContainer/Label_XPToLevel.set_text("XP to level " + str(Globals.player.strength_level[muscle] + 1) + ": ")
	$Panel/VBoxContainer/HBoxContainer2/Label_CurrentTotalXP.set_text(str(Globals.player.xp_total[muscle]))
