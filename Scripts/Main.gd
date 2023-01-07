extends Node

var selected_exercise
var money_earned
var strength_earned

onready var player_balance = $SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance

func _ready():
	Globals.loadGame()
	player_balance.updateBalance()
	$SidePanel.updateStrengthLevels()

func setActiveExerciseUI():
	money_earned = Globals.calculateMoneyEarned(selected_exercise.rep_time)
	strength_earned = selected_exercise.base_strength
	
	$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
	
	$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(str(selected_exercise.rep_time) + "s")
	$SidePanel/VBox_Main/Panel2/ActiveExercise/RepTimer.set_wait_time(selected_exercise.rep_time)
	
	$SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + str(money_earned))


# Signals / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

func openStore():
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


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	$SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance.updateBalance()
