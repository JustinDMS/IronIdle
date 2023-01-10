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
onready var unit_req = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox2/VBoxContainer/HBox_Requirements/Label_UnitReq
onready var equipment_req = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox2/VBoxContainer/HBox_Requirements2/Label_EquipmentReq
onready var level_texture = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox2/VBoxContainer/HBox_Requirements3/TextureRect
onready var level_req = $VBox_Main/HBoxContainer/ExerciseInfo/Panel/VBoxContainer/HBox_Main/VBox2/VBoxContainer/HBox_Requirements3/Label_LevelReq


func _ready():
	pass


func applyFilter():
	$VBox_Main/ExerciseButtons.filterExercises(type_filter, muscle_filter)


# Signal to update the ExerciseInfo scene
func _on_ExerciseButtons_exercise_selected(index):
	
	var strength = Globals.player.strength_level[exercise_list[index]["muscle_groups"]]
	var proficiency = Globals.player.proficiency_level[exercise_list[index]["exercise_name"]]
	var time = exercise_list[index]["rep_time"]
	var texture = Globals.muscle_icons[exercise_list[index]["muscle_groups"]]
	
	name_label.set_text(exercise_list[index]["exercise_name"] + ":")
	money_label.set_text(Globals.calculateMoneyEarned(exercise_list[index]["rep_time"]))
	time_label.set_text(Globals.calculateRepTime(strength, proficiency, time))
	muscle_texture.set_texture(texture)
	strength_label.set_text(str(exercise_list[index]["base_strength"]) + " xp")
	proficiency_label.set_text(str("1" + " xp"))
	unit_req.set_text("Unit: " + exercise_list[index]["unit_req"])
	equipment_req.set_text("Equipment: " + exercise_list[index]["equipment_req_1"] + ", " + exercise_list[index]["equipment_req_2"])
	level_texture.set_texture(texture)
	level_req.set_text("Level " + str(exercise_list[index]["level_requirement"]))


func determineUnlocked():
	
	var unit = Globals.player.gym_units.has(selected_exercise.unit_req)
	var equipment_1 = Globals.player.gym_equipment.has(selected_exercise.equipment_req_1)
	var equipment_2 = Globals.player.gym_equipment.has(selected_exercise.equipment_req_2)
	var level = Globals.player.strength_level[selected_exercise.muscle_groups] >= selected_exercise.level_requirement
	
	if unit == true and equipment_1 == true and equipment_2 == true and level == true:
		return true
	
	else:
		return false


# Signal to update the ActiveExercise scene
func _on_ExerciseButtons_exercise_activated(index):
	selected_exercise = exercise_list[index]
	
	if determineUnlocked():
		emit_signal("sent_info")
	
	else:
		print("Doesn't meet requirements")

# Exercise list filter buttons

func _on_Button_ClearFilters_pressed():
	muscle_filter = "All"
	type_filter = "All"
	applyFilter()


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
	type_filter = "Dumbbells"
	applyFilter()

func _on_Button_Barbell_pressed():
	type_filter = "Barbell"
	applyFilter()



