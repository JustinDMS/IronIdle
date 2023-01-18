extends Node

var selected_exercise
var money_earned
var strength_earned
var proficiency_earned = 1
var exercise_dict = {}

var has_caffeine : bool
var has_creatine : bool
var has_bcaa : bool

onready var player_balance = $SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance

func _ready():
	Globals.loadGame()
	player_balance.updateBalance()
	$SidePanel.initDisplay()
	$SidePanel/Inventory.updateInventory()
	$ExerciseSelect.fillGrid()
	makeExerciseDict()


func setActiveExerciseUI():
	
	if selected_exercise == null:
		return
	
	else:
		if Globals.player.active_supplements["Creatine"] > 0:
			strength_earned = selected_exercise.base_strength * 2
			has_creatine = true
		else:
			strength_earned = selected_exercise.base_strength
			has_creatine = false
		
		var strength = Globals.player.strength_level[selected_exercise.muscle_groups]
		var proficiency = Globals.player.proficiency_level[selected_exercise.exercise_name]
		var rep_time
		
		if Globals.player.active_supplements["Caffeine"] > 0:
			rep_time = str(float(Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)) * 0.8)
			has_caffeine = true
		else:
			rep_time = Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)
			has_caffeine = false
		
		if Globals.player.active_supplements["BCAA"] > 0:
			proficiency_earned = 2
		else:
			proficiency_earned = 1
			
		money_earned = Globals.calculateMoneyEarned(proficiency, selected_exercise.rep_time)
	
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(rep_time + "s")
		$SidePanel/VBox_Main/Panel2/ActiveExercise/RepTimer.set_wait_time(float(rep_time))
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + str(money_earned))


func checkSupplements():
	
	var amount : int
	
	if has_caffeine == true:
		amount = Globals.player.active_supplements["Caffeine"]
		Globals.player.active_supplements["Caffeine"] = amount - 1
		print("Caffeine remaining: " + str(Globals.player.active_supplements["Caffeine"]))
		if Globals.player.active_supplements["Caffeine"] < 1:
			has_caffeine = false
			setActiveExerciseUI()
	
	if has_creatine == true:
		amount = Globals.player.active_supplements["Creatine"]
		Globals.player.active_supplements["Creatine"] = amount - 1
		print("Creatine remaining: " + str(Globals.player.active_supplements["Creatine"]))
		if Globals.player.active_supplements["Creatine"] < 1:
			has_creatine = false
			setActiveExerciseUI()
	
	if has_bcaa == true:
		amount = Globals.player.active_supplements["BCAA"]
		Globals.player.active_supplements["BCAA"] = amount - 1
		print("BCAA remaining: " + str(Globals.player.active_supplements["BCAA"]))
		if Globals.player.active_supplements["BCAA"] < 1:
			has_bcaa = false
			setActiveExerciseUI()


func updateProficiencyProgress(exercise):
	if is_instance_valid(exercise_dict[exercise.exercise_name]):
		exercise_dict[exercise.exercise_name].updateProgress(exercise)


func experiencePurchased(muscle_group):
	$SidePanel.updateProgress(muscle_group)


func refreshExercisePanels(): # To update the dropdown menu on strength or proficiency level up
	$ExerciseSelect.applyFilter()


# Signals / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / 


func openStore():
	$ExerciseSelect.hide()
	$Store.show()


func receivedExerciseInfo():
	$SidePanel/VBox_Main/Panel2/Panel2_Cover.hide()
	
	if selected_exercise == $ExerciseSelect.selected_exercise:
		setActiveExerciseUI()
	else:
		$SidePanel/VBox_Main/Panel2/ActiveExercise.stopExercise()
		selected_exercise = $ExerciseSelect.selected_exercise
		setActiveExerciseUI()


func makeExerciseDict():
	
	for i in $ExerciseSelect/VBox_Main/ScrollContainer/GridContainer.get_children():
		var temp = i.find_node("ProficiencyProgress")
		exercise_dict[temp.exercise.exercise_name] = temp


func completedRep():
	Globals.player.money += float(money_earned)
	player_balance.updateBalance()

	Globals.gainExperience(selected_exercise.muscle_groups, strength_earned)
	print("Strength earned = " + str(strength_earned))
	$SidePanel.updateProgress(selected_exercise.muscle_groups)

	Globals.gainProficiencyExperience(selected_exercise.exercise_name, proficiency_earned)
	print("Proficiency earned = " + str(proficiency_earned))
	updateProficiencyProgress(selected_exercise)
	
	checkSupplements()


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	player_balance.updateBalance()
	Globals.saveGame()


func _on_Store_experience_purchase_made(muscle):
	player_balance.updateBalance()
	experiencePurchased(muscle)
