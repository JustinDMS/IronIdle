extends Node



# Exercise info

# Calisthenics
var pushup = load("res://Exercises/PushUp.tres")
var situp = load("res://Exercises/SitUp.tres")
var pullup = load("res://Exercises/PullUp.tres")
var bodyweight_squat = load("res://Exercises/BodyweightSquat.tres")

# Weighted
var benchpress = load("res://Exercises/BenchPress.tres")
var overheadpress = load("res://Exercises/OverheadPress.tres")
var squat = load("res://Exercises/Squat.tres")
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

# Player variables

var player = Player.new()
const save_path = "res://Save/savegame.res"

func _ready():
	createExerciseArray()


func createExerciseArray():
	all_exercises.append(pushup)
	all_exercises.append(situp)
	all_exercises.append(pullup)
	all_exercises.append(bodyweight_squat)
	all_exercises.append(benchpress)
	all_exercises.append(overheadpress)
	all_exercises.append(squat)
	all_exercises.append(deadlift)


func calculateMoneyEarned(time):
	return str("%.2f" % (pow(time, 1.75)/100))


func calculateStrengthXPForLevel(level):
	return int(level + 50 * (pow(2, (level / 6))))


func updateExperienceRequired(muscle):
	experience_required = calculateStrengthXPForLevel(player.strength_level[muscle] + 1)

func gainExperience(muscle, amount):
	
	updateExperienceRequired(muscle)
	
	player.xp_total[muscle] += amount
	player.xp[muscle] += amount
	
	while player.xp[muscle] >= experience_required:
		player.xp[muscle] -= experience_required
		levelUp(muscle)


func levelUp(muscle):

	player.strength_level[muscle] += 1
	updateExperienceRequired(muscle)


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

	var result = ResourceSaver.save("res://Save/savegame.res", player)
	assert(result == OK)
	print("Game saved")
