extends Control

signal sent_info

var selected_exercise
var type_filter := "All"
var muscle_filter := "All"
onready var exercise_list : Array = $VBox_Main/ExerciseButtons.filtered_exercises

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

func applyFilter():
	$VBox_Main/ExerciseButtons.filterExercises(type_filter, muscle_filter)


# Signal to update the ExerciseInfo scene
func _on_ExerciseButtons_exercise_selected(index):
	$VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBoxContainer3/Label_Name.set_text(exercise_list[index]["exercise_name"] + ":")
	$VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBoxContainer/Label_Money.set_text(Globals.calculateMoneyEarned(exercise_list[index]["rep_time"]))
	$VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBoxContainer2/Label_RepTime.set_text(str(exercise_list[index]["rep_time"]))
	
	$VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBoxContainer4/TextureRect.set_texture(Globals.muscle_icons[exercise_list[index]["muscle_groups"]])
	$VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBoxContainer4/Label_Strength.set_text(str(exercise_list[index]["base_strength"]) + " xp")

# Signal to update the ActiveExercise scene
func _on_ExerciseButtons_exercise_activated(index):
	selected_exercise = exercise_list[index]
	emit_signal("sent_info")

# Exercise list filter buttons

func _on_Button_Chest_pressed():
	muscle_filter = "Chest"
	applyFilter()


func _on_Button_Shoulder_pressed():
	muscle_filter = "Shoulders"
	applyFilter()

func _on_Button_Back_pressed():
	muscle_filter = "Back"
	applyFilter()

func _on_Button_Core_pressed():
	muscle_filter = "Core"
	applyFilter()

func _on_Button_Quads_pressed():
	muscle_filter = "Quadriceps"
	applyFilter()

func _on_Button_Hamstring_pressed():
	muscle_filter = "Hamstrings"
	applyFilter()

# Exercise type filters

func _on_Button_Calisthenics_pressed():
	type_filter = "Calisthenic"
	applyFilter()

func _on_Button_Dumbbell_pressed():
	type_filter = "Weighted"
	applyFilter()

func _on_Button_Barbell_pressed():
	type_filter = "Weighted"
	applyFilter()
