extends Node

var selected_exercise
var money_earned


func _ready():
	Globals.loadGame()


func setActiveExerciseUI():
	money_earned = Globals.calculateMoneyEarned(selected_exercise.rep_time)
	
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
	Globals.money += float(money_earned)
	$SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance.updateBalance()


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	$SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance.updateBalance()


# Destructor
func _on_Main_tree_exiting():
	Globals.saveGame()
