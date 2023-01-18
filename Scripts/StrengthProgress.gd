extends Control

var display
var instance
var muscle_group

onready var muscle_texture = $HBoxContainer/Texture_Muscle
onready var muscle_label = $HBoxContainer/VBoxContainer/Label_Muscle
onready var level_label = $HBoxContainer/VBoxContainer/Label_Level
onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar


func initDisplay(muscle : String):
	
	muscle_group = muscle
	
	muscle_texture.set_texture(Globals.muscle_icons[muscle])
	muscle_label.set_text(muscle)
	
	updateProgress(muscle)


func updateProgress(muscle):
	progress_bar.set_max(Globals.calculateStrengthXPForLevel(Globals.player.strength_level[muscle]))
	progress_bar.set_value(Globals.player.xp[muscle])
	
	level_label.set_text("Level " + str(Globals.player.strength_level[muscle]))
	
	if is_instance_valid(instance):
		instance.setXPDisplay("Strength", null, muscle)


func _on_ProgressBar_mouse_entered():
	display = load("res://Scenes/XPDisplay.tscn")
	instance = display.instance()
	instance.setXPDisplay("Strength", null, muscle_group)
	self.add_child(instance)


func _on_ProgressBar_mouse_exited():
	if is_instance_valid(instance):
		instance.queue_free()
