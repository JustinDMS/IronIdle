extends Control


signal setting_changed(setting, is_on)


func _process(_delta):
	if self.is_visible_in_tree():
		if not Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()): # Has mouse left panel (ignoring child controls)
			hide()


func settingChanged(setting : String, button_pressed : bool):
	print("Button toggled")
	Globals.player.settings[setting] = button_pressed
	emit_signal("setting_changed", setting, button_pressed)


func _on_CheckBox_StrengthXP_toggled(button_pressed):
	settingChanged("Strength XP", button_pressed)


func _on_CheckBox_ProficiencyXP_toggled(button_pressed):
	settingChanged("Proficiency XP", button_pressed)


func _on_CheckBox_Money_toggled(button_pressed):
	settingChanged("Money", button_pressed)


