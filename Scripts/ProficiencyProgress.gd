extends Control

var exercise
var display
var instance
var is_max := false

func _ready():
	pass


func updateProgress(item):
	
	if not is_max:
		exercise = item
		$VBoxContainer/Label_Proficiency.set_text("Level " + str(Globals.player.proficiency_level[item.exercise_name]))
		$VBoxContainer/ProgressBar.set_max(Globals.calculateProficiencyXPForLevel(Globals.player.proficiency_level[item.exercise_name]))
		$VBoxContainer/ProgressBar.set_value(Globals.player.proficiency_xp[item.exercise_name])
	
		if is_instance_valid(instance):
			instance.setXPDisplay("Proficiency", exercise, null)
		
		if Globals.player.proficiency_level[item.exercise_name] == 20:
			setMaxOut()
	
	else:
		if is_instance_valid(instance):
			instance.setXPDisplay("Proficiency", exercise, null)


func setMaxOut():
	var value = Globals.calculateProficiencyXPForLevel(20)
	$VBoxContainer/ProgressBar.set_max(value)
	$VBoxContainer/ProgressBar.set_value(value)
	$VBoxContainer/ProgressBar.set_percent_visible(false)
	
	var new_style = load("res://UI/MaxProgressBar_StyleBox.tres")
	$VBoxContainer/ProgressBar.set("custom_styles/fg", new_style)
	
	is_max = true

func _on_ProgressBar_mouse_entered():
	display = load("res://Scenes/XPDisplay.tscn")
	instance = display.instance()
	instance.setXPDisplay("Proficiency", exercise, null)
	self.add_child(instance)

func _on_ProgressBar_mouse_exited():
	if is_instance_valid(instance):
		instance.queue_free()
