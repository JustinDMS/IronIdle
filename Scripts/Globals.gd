extends Node

# Exercise info

# Calisthenics
var pushup = load("res://Exercises/PushUp.tres")
var situp = load("res://Exercises/SitUp.tres")
var pullup = load("res://Exercises/PullUp.tres")
var bodyweight_squat = load("res://Exercises/BodyweightSquat.tres")

# Dumbbell
var latraise = load("res://Exercises/LateralRaise.tres")
var dumbbellrow = load("res://Exercises/DumbbellRow.tres")
var dumbbellbench = load("res://Exercises/DumbbellBenchPress.tres")
var dumbbelldeadlift = load("res://Exercises/DumbbellDeadlift.tres")
var dumbbellpress = load("res://Exercises/DumbbellPress.tres")
var gobletsquat = load("res://Exercises/GobletSquat.tres")

# Barbell
var benchpress = load("res://Exercises/BenchPress.tres")
var barbellpress = load("res://Exercises/BarbellPress.tres")
var barbellrow = load("res://Exercises/BarbellRow.tres")
var barbellsquat = load("res://Exercises/BarbellSquat.tres")
var deadlift = load("res://Exercises/Deadlift.tres")

# Icons for muscle group
var muscle_icons = {
	"Chest" : preload("res://Art/ChestIcon.png"),
	"Shoulders" : preload("res://Art/ShouldersIcon.png"),
	"Back" : preload("res://Art/BackIcon.png"),
	"Core" : preload("res://Art/CoreIcon.png"),
	"Quadriceps" : preload("res://Art/QuadricepsIcon.png"),
	"Hamstrings" : preload("res://Art/HamstringsIcon.png"),
}
var muscle_icons_small = {
	"Chest" : preload("res://Art/SmallIcons/ChestIcon_Small.png"),
	"Shoulders" : preload("res://Art/SmallIcons/ShouldersIcon_Small.png"),
	"Back" : preload("res://Art/SmallIcons/BackIcon_Small.png"),
	"Core" : preload("res://Art/SmallIcons/CoreIcon_Small.png"),
	"Quadriceps" : preload("res://Art/SmallIcons/QuadricepsIcon_Small.png"),
	"Hamstrings" : preload("res://Art/SmallIcons/HamstringsIcon_Small.png"),
}

# Icons for the exercise type
var type_icons = {
	"Calisthenic" : preload("res://Art/CalisthenicIcon.png"),
	"Dumbbell" : preload("res://Art/DumbbellIcon.png"),
	"Barbell" : preload("res://Art/BarbellIcon.png"),
	"Machine" : preload("res://Art/MachineIcon.png"),
}

var inventory_items = {
	"Pull-Up Bar" : "gym_units", 
	"Bench" : "gym_units", 
	"Barbell Rack" : "gym_units", 
	"Deadlift Platform" : "gym_units",
	
	"Barbell" : "gym_equipment", 
	"Dumbbells" : "gym_equipment",
	"Plates" : "gym_equipment",
	
	"Caffeine" : "gym_supplements",
	"Creatine" : "gym_supplements",
	"BCAA" : "gym_supplements",
}

var all_exercises = []

var experience_required
var proficiency_required
onready var main = get_tree().get_nodes_in_group("UI")


# Player variables

var player = Player.new()
const save_path := "user://savegamev1.1.res"

func _ready():
	createExerciseArray()


func createExerciseArray():
	all_exercises.append(pushup)
	all_exercises.append(situp)
	all_exercises.append(pullup)
	all_exercises.append(bodyweight_squat)
	
	all_exercises.append(latraise)
	all_exercises.append(dumbbellbench)
	all_exercises.append(dumbbelldeadlift)
	all_exercises.append(dumbbellpress)
	all_exercises.append(dumbbellrow)
	all_exercises.append(gobletsquat)
	
	all_exercises.append(benchpress)
	all_exercises.append(barbellpress)
	all_exercises.append(barbellrow)
	all_exercises.append(barbellsquat)
	all_exercises.append(deadlift)


func calculateMoneyEarned(proficiency, base_time):
	var proficiency_modifier = pow(proficiency/9.99, 2)
	var money = pow(base_time, 1.75)/9.99
	
	return str("%.2f" % (money + (money * proficiency_modifier)))


func calculateStrengthXPForLevel(level):
	return int(level + 50 * (pow(2, (level / 6))))


func calculateProficiencyXPForLevel(level):
	return int(level + 75 * (pow(2, (level / 4))))


func calculateRepTime(strength, proficiency, time):
	
	var strength_modifier = strength/49.99
	var proficiency_modifier = proficiency/19.99
	
	var result = time - (strength_modifier/5) - (proficiency_modifier/4)
	result = str("%.3f" % result)

	return result


func updateExperienceRequired(muscle):
	experience_required = calculateStrengthXPForLevel(player.strength_level[muscle])


func updateProficiencyExperienceRequired(exercise : String):
	proficiency_required = calculateProficiencyXPForLevel(player.proficiency_level[exercise])


func gainExperience(muscle, amount):
	
	updateExperienceRequired(muscle)
	
	player.xp_total[muscle] += amount
	player.xp[muscle] += amount
	
	while player.xp[muscle] >= experience_required:
		player.xp[muscle] -= experience_required
		levelUpStrength(muscle)


func gainProficiencyExperience(exercise : String, amount):
	
	updateProficiencyExperienceRequired(exercise)
	
	player.proficiency_xp_total[exercise] += amount
	player.proficiency_xp[exercise] += amount
	
	while player.proficiency_xp[exercise] >= proficiency_required:
		player.proficiency_xp[exercise] -= proficiency_required
		levelUpProficiency(exercise)


func levelUpStrength(muscle):

	player.strength_level[muscle] += 1
	updateExperienceRequired(muscle)
	main[0].call("setActiveExerciseUI")
	main[0].call("refreshExercisePanels")


func levelUpProficiency(exercise):
	player.proficiency_level[exercise] += 1
	updateProficiencyExperienceRequired(exercise)
	main[0].call("setActiveExerciseUI")
	main[0].call("refreshExercisePanels")


func loadGame():

	if ResourceLoader.exists(save_path):
		player = ResourceLoader.load(save_path)
		if player is Player: # Check if data is valid
			print("Game loaded")
			return player # Return value is either a Player object or null
	
	else:
		print("Save not found. Creating new save")
		saveGame()


func saveGame():

	var result = ResourceSaver.save(save_path, player)
	assert(result == OK)
	print("Game saved")
