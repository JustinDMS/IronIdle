extends Control

var exercise
var display
var instance

func _ready():
	pass


func updateProgress(item):
	$VBoxContainer/Label_Proficiency.set_text("Level " + str(Globals.player.proficiency_level[item.exercise_name]))
	$VBoxContainer/ProgressBar.set_max(Globals.calculateProficiencyXPForLevel(Globals.player.proficiency_level[item.exercise_name]))
	$VBoxContainer/ProgressBar.set_value(Globals.player.proficiency_xp[item.exercise_name])
	
	if is_instance_valid(instance):
		instance.setXPDisplay("Proficiency", exercise, null)


func _on_ProgressBar_mouse_entered():
	display = load("res://Scenes/XPDisplay.tscn")
	instance = display.instance()
	instance.setXPDisplay("Proficiency", exercise, null)
	self.add_child(instance)

func _on_ProgressBar_mouse_exited():
	if is_instance_valid(instance):
		instance.queue_free()
