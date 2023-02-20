extends Control

signal sent_info
signal list_changed

var selected_exercise
var type_filter := "All"
var muscle_filter := "All"
var filtered_exercises = []
var grid

var highlight = preload("res://Art/HighlightIcon.png")
var highlighticon_type
var highlighticon_muscle
var previous_type_filter := "All"
var previous_muscle_filter := "All"

onready var muscle_search = {
	"All" : null,
	"Chest" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Chest,
	"Shoulders" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Shoulder,
	"Back" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Back,
	"Core" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Core,
	"Quadriceps" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Quads,
	"Hamstrings" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup/Button_Hamstring,
}
onready var type_search = {
	"All" : null,
	"Calisthenic" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup2/Button_Calisthenics,
	"Dumbbell" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup2/Button_Dumbbell,
	"Barbell" : $VBox_Main/HBoxContainer/VBoxContainer/HBox_MuscleGroup2/Button_Barbell,
}

func _ready():
	initHighlightIcon()


func fillGrid():
	
	grid = $VBox_Main/ScrollContainer/GridContainer
	
	for i in Globals.all_exercises:
		appendExercise(i)
	
	# Workaround for ScrollContainer bug not showing the last elements
	appendExercise(Globals.blank_exercise)


func appendExercise(item):
	
	if item.exercise_name.match("Blank"):
		return
	
	var instance
	var scene = load("res://Scenes/ExercisePanel.tscn")
	
	instance = scene.instance()
	instance.connect("selected_item", self, "activateExercise")
	instance.createPanel(item.exercise_name, Globals.muscle_icons[item.muscle_groups], Globals.type_icons[item.exercise_type], item)
	grid.add_child(instance)


func filterExercises(type, group):
	
	clearGrid()
	filtered_exercises.clear()
	
	for i in Globals.all_exercises:
		
		if type == "All" and group == "All":
			filtered_exercises.append(i)
		
		elif type == "All":
			if i["muscle_groups"] == group:
				filtered_exercises.append(i)
		
		elif group == "All":
			if i["exercise_type"] == type:
				filtered_exercises.append(i)
		
		elif i["exercise_type"] == type and i["muscle_groups"] == group:
			filtered_exercises.append(i)

	
	for i in filtered_exercises:
		appendExercise(i)
	
	# Workaround for ScrollContainer bug not showing the last elements
	if type == "All" and group == "All":
		appendExercise(Globals.blank_exercise)
	
	emit_signal("list_changed")


func updateHighlight(type, group):
	
	if type_search[previous_type_filter] != null: 
		type_search[previous_type_filter].remove_child(highlighticon_type)
		
	if muscle_search[previous_muscle_filter] != null: 
		muscle_search[previous_muscle_filter].remove_child(highlighticon_muscle)
	
	match type:
		"All":
			previous_type_filter = type
		_:
			previous_type_filter = type
			type_search[type].add_child(highlighticon_type)
	
	match group:
		"All":
			previous_muscle_filter = group
		_:
			previous_muscle_filter = group
			muscle_search[group].add_child(highlighticon_muscle)


func applyFilter():
	filterExercises(type_filter, muscle_filter)
	updateHighlight(type_filter, muscle_filter)


func clearGrid():
	for n in grid.get_children():
		n.queue_free()


func activateExercise(exercise):
	selected_exercise = exercise
	emit_signal("sent_info")


func initHighlightIcon():
	var texture = TextureRect.new()
	var texture2 = TextureRect.new()
	
	texture.set_texture(highlight)
	texture.set_expand(true)
	texture.set_stretch_mode(1)
	texture.anchor_right = 1
	texture.anchor_bottom = 1
	
	texture2.set_texture(highlight)
	texture2.set_expand(true)
	texture2.set_stretch_mode(1)
	texture2.anchor_right = 1
	texture2.anchor_bottom = 1
	
	highlighticon_type = texture
	highlighticon_muscle = texture2
	


# Exercise list filter buttons

func _on_Button_ClearMuscle_pressed():
	muscle_filter = "All"
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
	type_filter = "Dumbbell"
	applyFilter()

func _on_Button_Barbell_pressed():
	type_filter = "Barbell"
	applyFilter()

func _on_Button_ClearType_pressed():
	type_filter = "All"
	applyFilter()
