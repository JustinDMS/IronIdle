extends Control

signal clicked_store
signal completed_rep

func _ready():
	pass 


func _on_Button_Store_pressed():
	emit_signal("clicked_store")


func _on_ActiveExercise_completed_rep():
	emit_signal("completed_rep")
