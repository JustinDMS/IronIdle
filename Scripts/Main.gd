extends Node

var selected_exercise
var money_earned
var strength_earned
var proficiency_earned = 1
var exercise_dict = {}

onready var player_balance = $SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance

func _ready():
	Globals.loadGame()
	player_balance.updateBalance()
	$SidePanel.initDisplay()
	$ExerciseSelect.fillGrid()
	makeExerciseDict()


func setActiveExerciseUI():
	
	if selected_exercise == null:
		return
	
	else:
		strength_earned = selected_exercise.base_strength
	
		var strength = Globals.player.strength_level[selected_exercise.muscle_groups]
		var proficiency = Globals.player.proficiency_level[selected_exercise.exercise_name]
		var rep_time = Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)
		
		print(rep_time)
		
		money_earned = Globals.calculateMoneyEarned(proficiency, selected_exercise.rep_time)
	
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(rep_time + "s")
		$SidePanel/VBox_Main/Panel2/ActiveExercise/RepTimer.set_wait_time(float(rep_time))
		$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + str(money_earned))


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
	$SidePanel.updateProgress(selected_exercise.muscle_groups)

	Globals.gainProficiencyExperience(selected_exercise.exercise_name, proficiency_earned)
	updateProficiencyProgress(selected_exercise)


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	player_balance.updateBalance()


func _on_Store_experience_purchase_made(muscle):
	player_balance.updateBalance()
	experiencePurchased(muscle)
