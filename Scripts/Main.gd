extends Node

var selected_exercise
var money_earned
var strength_earned
var proficiency_earned = 1

onready var player_balance = $SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance

func _ready():
	Globals.loadGame()
	player_balance.updateBalance()
	$SidePanel.updateStrengthLevels()
	updateInventory()

func setActiveExerciseUI():
	
	if selected_exercise == null:
		return
	
	else:
		money_earned = Globals.calculateMoneyEarned(selected_exercise.rep_time)
		strength_earned = selected_exercise.base_strength
	
		var strength = Globals.player.strength_level[selected_exercise.muscle_groups]
		var proficiency = Globals.player.proficiency_level[selected_exercise.exercise_name]
		var rep_time = Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)
	
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(rep_time + "s")
		$SidePanel/VBox_Main/Panel2/ActiveExercise/RepTimer.set_wait_time(float(rep_time))
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + str(money_earned))
	
		updateProficiencyUI()


func updateProficiencyUI():
	var proficiency_level = str(Globals.player.proficiency_level[selected_exercise.exercise_name])
	var proficiency_xp = str(Globals.calculateProficiencyXPForLevel(Globals.player.proficiency_level[selected_exercise.exercise_name]) - Globals.player.proficiency_xp[selected_exercise.exercise_name])
	$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ProficiencyLevel.set_text("Current Proficiency: " + proficiency_level)
	$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ProficiencyXP.set_text("XP to Proficiency Level: " + proficiency_xp)


func updateInventory():
	
	var unit = $ExerciseSelect/VBox_Main/HBoxContainer2/Inventory/VBoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/Label_UnitsInventory
	var equip = $ExerciseSelect/VBox_Main/HBoxContainer2/Inventory/VBoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/Label_EquipmentInventory
	var text = ""
	
	for i in Globals.player.gym_units:
		
		if i == "None":
			continue
		
		else:
			text = text + "\n" + i

	unit.set_text(text)
	
	text = ""
	
	for i in Globals.player.gym_equipment:
		
		if i == "None":
			continue
		
		else:
			text = text + "\n" + i
	
	equip.set_text(text)

# Signals / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

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


func completedRep():
	Globals.player.money += float(money_earned)
	player_balance.updateBalance()

	Globals.gainExperience(selected_exercise.muscle_groups, strength_earned)
	$SidePanel.updateStrengthLevels()
	$SidePanel.updateDisplayXP(selected_exercise.muscle_groups)

	Globals.gainProficiencyExperience(selected_exercise.exercise_name, proficiency_earned)
	updateProficiencyUI()

func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	player_balance.updateBalance()
	$SidePanel.updateStrengthLevels()
	updateInventory()
