extends Control

signal sent_info
signal clicked_store

var selected_exercise

func _ready():
	pass

func determineUnlocked(button, exercise):
	
	print("\n" + exercise.exercise_name)
	var gym_check = Globals.gym.has(exercise.gym_req)
	var equipment_check = Globals.equipment.has(exercise.equipment_req)
	
	if gym_check == true and equipment_check == true:
		button.set_disabled(false)
		
	else:
		print("Gym check: " + str(gym_check))
		print("Equipment check: " + str(equipment_check))
		button.set_disabled(true)
		return false


func _on_Button_Store_pressed():
	emit_signal("clicked_store")
	hide()

func _on_Button_PushUp_pressed():
	selected_exercise = Globals.pushup
	emit_signal("sent_info")
	hide()

func _on_Button_SitUp_pressed():
	selected_exercise = Globals.situp
	emit_signal("sent_info")
	hide()


func _on_Button_PullUp_pressed():
	selected_exercise = Globals.pullup
	emit_signal("sent_info")
	hide()


func _on_Button_BodyweightSquat_pressed():
	selected_exercise = Globals.bodyweight_squat
	emit_signal("sent_info")
	hide()


func _on_Button_BenchPress_pressed():
	selected_exercise = Globals.benchpress
	emit_signal("sent_info")
	hide()


func _on_Button_OverheadPress_pressed():
	selected_exercise = Globals.overheadpress
	emit_signal("sent_info")
	hide()


func _on_Button_Squat_pressed():
	selected_exercise = Globals.squat
	emit_signal("sent_info")
	hide()


func _on_Button_Deadlift_pressed():
	selected_exercise = Globals.deadlift
	emit_signal("sent_info")
	hide()
