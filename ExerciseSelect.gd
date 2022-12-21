extends Control

signal sent_info
signal clicked_store

var selected_exercise

func _ready():
	pass

func determineUnlocked(exercise):
	var gym_check = Globals.gym.has(exercise.gym_req)
	var equipment_check = Globals.equipment.has(exercise.equipment_req)
	if gym_check == true and equipment_check == true:
		return true
	else:
		print("Gym check: " + str(gym_check))
		print("Equipment check: " + str(equipment_check))
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


func _on_Button_PullUp_tree_entered():
	if determineUnlocked(Globals.pullup) == false:
		$VerticalBox_Main/VerticalBox_Calisthenic/Button_PullUp.set_disabled(true)
	else:
		$VerticalBox_Main/VerticalBox_Calisthenic/Button_PullUp.set_disabled(false)

func _on_Button_PullUp_pressed():
	selected_exercise = Globals.pullup
	emit_signal("sent_info")
	hide()
