extends Control

signal sent_info

var selected_exercise
var type_filter := "All"
var muscle_filter := "All"
onready var exercise_list : Array = $VBox_Main/ExerciseButtons.filtered_exercises

onready var name_label = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/Label_Name
onready var money_label = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox1/HBox_Money/Label_Money
onready var time_label = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox1/HBox_Time/Label_RepTime
onready var muscle_texture = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox1/HBox_Strength/TextureRect
onready var strength_label = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox1/HBox_Strength/Label_Strength
onready var proficiency_label = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox1/HBox_Proficiency/Label_Proficiency

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
	
	var strength = Globals.player.strength_level[exercise_list[index]["muscle_groups"]]
	var proficiency = Globals.player.proficiency_level[exercise_list[index]["exercise_name"]]
	var time = exercise_list[index]["rep_time"]
	
	name_label.set_text(exercise_list[index]["exercise_name"] + ":")
	money_label.set_text(Globals.calculateMoneyEarned(exercise_list[index]["rep_time"]))
	time_label.set_text(Globals.calculateRepTime(strength, proficiency, time))
	muscle_texture.set_texture(Globals.muscle_icons[exercise_list[index]["muscle_groups"]])
	strength_label.set_text(str(exercise_list[index]["base_strength"]) + " xp")
	proficiency_label.set_text(str("1" + " xp"))

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
