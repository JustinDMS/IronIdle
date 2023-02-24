extends Control

var display
var instance
var muscle_group
var is_max := false

onready var muscle_texture = $HBoxContainer/Texture_Muscle
onready var muscle_label = $HBoxContainer/VBoxContainer/Label_Muscle
onready var level_label = $HBoxContainer/VBoxContainer/Label_Level
onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar


func _process(_delta):
	if is_instance_valid(instance):
		if Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()):
			instance.set_global_position(get_global_mouse_position())
		else:
			instance.queue_free()


func initDisplay(muscle : String):
	
	muscle_group = muscle
	
	muscle_texture.set_texture(Globals.muscle_icons[muscle])
	muscle_label.set_text(muscle)
	
	updateProgress(muscle)


func updateProgress(muscle):
	
	if not is_max:
		progress_bar.set_max(Globals.calculateStrengthXPForLevel(Globals.player.strength_level[muscle]))
		progress_bar.set_value(Globals.player.xp[muscle])
	
		level_label.set_text("Level " + str(Globals.player.strength_level[muscle]))
	
		if is_instance_valid(instance):
			instance.setXPDisplay("Strength", null, muscle)
		
		if Globals.player.strength_level[muscle] == 50:
			setMaxOut()
	
	else:
		if is_instance_valid(instance):
			instance.setXPDisplay("Strength", null, muscle)


func setMaxOut():
	
	var value = Globals.calculateStrengthXPForLevel(50)
	$HBoxContainer/VBoxContainer/ProgressBar.set_max(value)
	$HBoxContainer/VBoxContainer/ProgressBar.set_value(value)
	$HBoxContainer/VBoxContainer/ProgressBar.set_percent_visible(false)
	
	var new_style = load("res://UI/MaxProgressBar_StyleBox.tres")
	$HBoxContainer/VBoxContainer/ProgressBar.set("custom_styles/fg", new_style)
	
	is_max = true


func _on_ProgressBar_mouse_entered():
	display = load("res://Scenes/XPDisplay.tscn")
	instance = display.instance()
	instance.setXPDisplay("Strength", null, muscle_group)
	Globals.main[0].add_child(instance)


func _on_ProgressBar_mouse_exited():
	if is_instance_valid(instance):
		instance.queue_free()


func _on_Button_Milestones_pressed():
	Globals.main[0].call("showMilestones", muscle_group)
