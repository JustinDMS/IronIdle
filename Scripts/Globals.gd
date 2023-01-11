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
	"Chest" : preload("res://PlaceholderArt/ChestIcon.png"),
	"Shoulders" : preload("res://PlaceholderArt/ShouldersIcon.png"),
	"Back" : preload("res://PlaceholderArt/BackIcon.png"),
	"Core" : preload("res://PlaceholderArt/AbsIcon.png"),
	"Quadriceps" : preload("res://PlaceholderArt/QuadsIcon.png"),
	"Hamstrings" : preload("res://PlaceholderArt/HamstringsIcon.png"),
}

var all_exercises = []
var experience_required
var proficiency_required
onready var main = get_tree().get_nodes_in_group("UI")

# Player variables

var player = Player.new()
const save_path := "user://savegame.res"

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


func calculateMoneyEarned(time):
	return str("%.2f" % (pow(time, 1.75)/50))


func calculateStrengthXPForLevel(level):
	return int(level + 50 * (pow(2, (level / 6))))


func calculateProficiencyXPForLevel(level):
	return int(level + 75 * (pow(2, (level / 3))))


func calculateRepTime(strength, proficiency, time):
	
	var strength_modifier = strength/50.0
	var proficiency_modifier = proficiency/20.0
	
	var result = time - (strength_modifier/5) - (proficiency_modifier/4)
	result = str("%.3f" % result)

	return result


func updateExperienceRequired(muscle):
	experience_required = calculateStrengthXPForLevel(player.strength_level[muscle] + 1)


func updateProficiencyExperienceRequired(exercise : String):
	proficiency_required = calculateProficiencyXPForLevel(player.proficiency_level[exercise] + 1)


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


func levelUpProficiency(exercise):
	player.proficiency_level[exercise] += 1
	updateProficiencyExperienceRequired(exercise)
	main[0].call("setActiveExerciseUI")


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
