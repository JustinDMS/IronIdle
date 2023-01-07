extends Control

signal clicked_store
signal completed_rep

var xp_display = preload("res://Scenes/XPDisplay.tscn")
var instance
var hovered_muscle

onready var display_timer = $XPDisplayTimer
var hover_time = 0.5

func _ready():
	updateStrengthLevels()

func updateStrengthLevels():
	# Level Display
	# Overkill to update all of the levels at once, but exercises should add strength to multiple groups in the future
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/HBox_Chest/Label_Chest.set_text(str(Globals.player.strength_level.Chest))
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/HBox_Shoulders/Label_Shoulders.set_text(str(Globals.player.strength_level.Shoulders))
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/HBox_Back/Label_Back.set_text(str(Globals.player.strength_level.Back))
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/HBox_Core/Label_Core.set_text(str(Globals.player.strength_level.Core))
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/HBox_Quadriceps/Label_Quadriceps.set_text(str(Globals.player.strength_level.Quadriceps))
	$VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/HBox_Hamstrings/Label_Hamstrings.set_text(str(Globals.player.strength_level.Hamstrings))


func displayXP(muscle):
	instance = xp_display.instance()
	updateDisplayXP(muscle)
	add_child(instance)


func updateDisplayXP(muscle):
	if is_instance_valid(instance):
		instance.setLabels(muscle)


func resetXPDisplay():
	
	display_timer.stop()
	
	if instance != null and is_instance_valid(instance):
		instance.queue_free()
		



func _on_Button_Store_pressed():
	emit_signal("clicked_store")


func _on_ActiveExercise_completed_rep():
	emit_signal("completed_rep")


func _on_XPDisplayTimer_timeout():
	displayXP(hovered_muscle)


# Signals for mouse hovering

func _on_HBox_Chest_mouse_entered():
	hovered_muscle = "Chest"
	display_timer.start(hover_time)


func _on_HBox_Chest_mouse_exited():
	resetXPDisplay()


func _on_HBox_Shoulders_mouse_entered():
	hovered_muscle = "Shoulders"
	display_timer.start(hover_time)


func _on_HBox_Shoulders_mouse_exited():
	resetXPDisplay()


func _on_HBox_Back_mouse_entered():
	hovered_muscle = "Back"
	display_timer.start(hover_time)


func _on_HBox_Back_mouse_exited():
	resetXPDisplay()


func _on_HBox_Core_mouse_entered():
	hovered_muscle = "Core"
	display_timer.start(hover_time)


func _on_HBox_Core_mouse_exited():
	resetXPDisplay()


func _on_HBox_Quadriceps_mouse_entered():
	hovered_muscle = "Quadriceps"
	display_timer.start(hover_time)


func _on_HBox_Quadriceps_mouse_exited():
	resetXPDisplay()


func _on_HBox_Hamstrings_mouse_entered():
	hovered_muscle = "Hamstrings"
	display_timer.start(hover_time)


func _on_HBox_Hamstrings_mouse_exited():
	resetXPDisplay()
