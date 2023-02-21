extends Node

# Exercise info

var blank_exercise = load("res://Exercises/Blank.tres")

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

var proficiency_icon = preload("res://Art/SmallIcons/ProficiencyIcon_Small.png")
var money_icon = preload("res://Art/SmallIcons/MoneyIcon_Small.png")

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

var no_imbalances_1 = preload("res://Challenges/NoImbalancesI.tres")
var no_imbalances_2 = preload("res://Challenges/NoImbalancesII.tres")
var no_imbalances_3 = preload("res://Challenges/NoImbalancesIII.tres")
var no_imbalances_4 = preload("res://Challenges/NoImbalancesIV.tres")
var no_imbalances_5 = preload("res://Challenges/NoImbalancesV.tres")
var favorite_muscle_1 = preload("res://Challenges/FavoriteMuscleI.tres")
var favorite_muscle_2 = preload("res://Challenges/FavoriteMuscleII.tres")
var favorite_muscle_3 = preload("res://Challenges/FavoriteMuscleIII.tres")
var favorite_muscle_4 = preload("res://Challenges/FavoriteMuscleIV.tres")
var favorite_muscle_5 = preload("res://Challenges/FavoriteMuscleV.tres")
var favorite_exercise_1 = preload("res://Challenges/FavoriteExerciseI.tres")
var favorite_exercise_2 = preload("res://Challenges/FavoriteExerciseII.tres")
var favorite_exercise_3 = preload("res://Challenges/FavoriteExerciseIII.tres")
var favorite_exercise_4 = preload("res://Challenges/FavoriteExerciseIV.tres")
var need_boost_1 = preload("res://Challenges/NeedBoostI.tres")
var need_boost_2 = preload("res://Challenges/NeedBoostII.tres")
var need_boost_3 = preload("res://Challenges/NeedBoostIII.tres")
var gain_train_1 = preload("res://Challenges/GainTrainI.tres")
var gain_train_2 = preload("res://Challenges/GainTrainII.tres")
var gain_train_3 = preload("res://Challenges/GainTrainIII.tres")
var focus_form_1 = preload("res://Challenges/FocusFormI.tres")
var focus_form_2 = preload("res://Challenges/FocusFormII.tres")
var focus_form_3 = preload("res://Challenges/FocusFormIII.tres")
var sponsor_me_1 = preload("res://Challenges/SponsorMeI.tres")
var sponsor_me_2 = preload("res://Challenges/SponsorMeII.tres")
var sponsor_me_3 = preload("res://Challenges/SponsorMeIII.tres")

var all_exercises = []
var all_challenges = []
var active_sponsor_tier

var experience_required
var proficiency_required
onready var main = get_tree().get_nodes_in_group("UI")


# Player variables

var player = Player.new()
const save_path := "res://Save/savegamev1.2.res"


func _ready():
	createExerciseArray()
	createChallengesArray()


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


func createChallengesArray():
	all_challenges.append(no_imbalances_1)
	all_challenges.append(no_imbalances_2)
	all_challenges.append(no_imbalances_3)
	all_challenges.append(no_imbalances_4)
	all_challenges.append(no_imbalances_5)
	
	all_challenges.append(favorite_muscle_1)
	all_challenges.append(favorite_muscle_2)
	all_challenges.append(favorite_muscle_3)
	all_challenges.append(favorite_muscle_4)
	all_challenges.append(favorite_muscle_5)
	
	all_challenges.append(favorite_exercise_1)
	all_challenges.append(favorite_exercise_2)
	all_challenges.append(favorite_exercise_3)
	all_challenges.append(favorite_exercise_4)
	
	all_challenges.append(need_boost_1)
	all_challenges.append(need_boost_2)
	all_challenges.append(need_boost_3)
	
	all_challenges.append(gain_train_1)
	all_challenges.append(gain_train_2)
	all_challenges.append(gain_train_3)
	
	all_challenges.append(focus_form_1)
	all_challenges.append(focus_form_2)
	all_challenges.append(focus_form_3)
	
	all_challenges.append(sponsor_me_1)
	all_challenges.append(sponsor_me_2)
	all_challenges.append(sponsor_me_3)


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


func claimChallenge(challenge):
	
	Globals.player.challenge_progress[challenge._name] = true
	main[0].call("buildChallengeList")
	main[0].call("applyCompletedChallengeBuff")
	main[0].call("setActiveExerciseUI")
	saveGame()


func getSupplementCharges(supplement : String):
	match supplement:
		"Caffeine":
			if Globals.player.challenge_progress["Need a Boost III"]:
				return 130
			elif Globals.player.challenge_progress["Need a Boost II"]:
				return 120
			elif Globals.player.challenge_progress["Need a Boost I"]:
				return 110
			else: return 100
		"Creatine":
			if Globals.player.challenge_progress["Gain Train III"]:
				return 130
			elif Globals.player.challenge_progress["Gain Train II"]:
				return 120
			elif Globals.player.challenge_progress["Gain Train I"]:
				return 110
			else: return 100
		"BCAA":
			if Globals.player.challenge_progress["Focus on Form III"]:
				return 130
			elif Globals.player.challenge_progress["Focus on Form II"]:
				return 120
			elif Globals.player.challenge_progress["Focus on Form I"]:
				return 110
			else: return 100


func getSponsorMeCharges(tier):
	match tier:
		null:
			return 0
		"I":
			return 50
		"II":
			return 100
		"III":
			return 200


func checkStrengthLevels(min_level : int):
	
	for i in Globals.player.strength_level:
		
		if Globals.player.strength_level[i] >= min_level:
			continue
		else:
			return false
	
	return true


func checkStrengthLevelThreshold(min_level : int):
	
	for i in Globals.player.strength_level:
		
		if Globals.player.strength_level[i] >= min_level:
			return true
		else:
			continue
	
	return false


func checkProficiencyLevelThreshold(min_level : int):
	
	for i in Globals.player.proficiency_level:
		
		if Globals.player.proficiency_level[i] >= min_level:
			return true
		else:
			continue
	
	return false


func checkSupplementUsage(supplement : String, min_amount : int):
	
	if Globals.player.supplements_used[supplement] >= min_amount:
		return true
	else:
		return false


func checkSponsorMeRequirements(tier):
	match tier:
		"Sponsor Me I":
			if Globals.player.challenge_progress["Need a Boost I"] and Globals.player.challenge_progress["Gain Train I"] and Globals.player.challenge_progress["Focus on Form I"]:
				return true
			else:
				return false
		"Sponsor Me II":
			if Globals.player.challenge_progress["Need a Boost II"] and Globals.player.challenge_progress["Gain Train II"] and Globals.player.challenge_progress["Focus on Form II"]:
				return true
			else:
				return false
		"Sponsor Me III":
			if Globals.player.challenge_progress["Need a Boost III"] and Globals.player.challenge_progress["Gain Train III"] and Globals.player.challenge_progress["Focus on Form III"]:
				return true
			else:
				return false


func getCanClaimChallenge(challenge_name):
	
	match challenge_name:
		
		"No Imbalances I":
			return checkStrengthLevels(10)
		"No Imbalances II":
			return checkStrengthLevels(20)
		"No Imbalances III":
			return checkStrengthLevels(30)
		"No Imbalances IV":
			return checkStrengthLevels(40)
		"No Imbalances V":
			return checkStrengthLevels(50)
		
		"Favorite Muscle I":
			return checkStrengthLevelThreshold(10)
		"Favorite Muscle II":
			return checkStrengthLevelThreshold(20)
		"Favorite Muscle III":
			return checkStrengthLevelThreshold(30)
		"Favorite Muscle IV":
			return checkStrengthLevelThreshold(40)
		"Favorite Muscle V":
			return checkStrengthLevelThreshold(50)
		
		"Favorite Exercise I":
			return checkProficiencyLevelThreshold(5)
		"Favorite Exercise II":
			return checkProficiencyLevelThreshold(10)
		"Favorite Exercise III":
			return checkProficiencyLevelThreshold(15)
		"Favorite Exercise IV":
			return checkProficiencyLevelThreshold(20)
		
		"Need a Boost I":
			return checkSupplementUsage("Caffeine", 5000)
		"Need a Boost II":
			return checkSupplementUsage("Caffeine", 10000)
		"Need a Boost III":
			return checkSupplementUsage("Caffeine", 25000)
		
		"Gain Train I":
			return checkSupplementUsage("Creatine", 5000)
		"Gain Train II":
			return checkSupplementUsage("Creatine", 10000)
		"Gain Train III":
			return checkSupplementUsage("Creatine", 25000)
		
		"Focus on Form I":
			return checkSupplementUsage("BCAA", 5000)
		"Focus on Form II":
			return checkSupplementUsage("BCAA", 10000)
		"Focus on Form III":
			return checkSupplementUsage("BCAA", 25000)
		
		"Sponsor Me I":
			return checkSponsorMeRequirements(challenge_name)
		"Sponsor Me II":
			return checkSponsorMeRequirements(challenge_name)
		"Sponsor Me III":
			return checkSponsorMeRequirements(challenge_name)


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
