extends Control

signal exercise_selected
signal exercise_activated

var icon = preload("res://PlaceholderArt/ExerciseIcon.png")
var filtered_exercises = []

func _ready():
	createExercises()

func createExercises():
	
	for i in Globals.all_exercises:
		$ItemList.add_item(i["exercise_name"], icon, true)
		filtered_exercises.append(i)

func filterExercises(type, group):
	
	$ItemList.clear()
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
		$ItemList.add_item(i["exercise_name"], icon, true)


func _on_ItemList_item_selected(index):
	emit_signal("exercise_selected", index)


func _on_ItemList_item_activated(index):
	emit_signal("exercise_activated", index)
