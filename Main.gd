extends Node

var selected_exercise

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.loadGame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setActiveExerciseUI():
	$ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
	$ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + str(selected_exercise.money_earned))
	updateMoneyLabel($ActiveExercise/VerticalBox_Main/Label_Money)
	
	$ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(str(selected_exercise.rep_time) + "s")
	$ActiveExercise/RepTimer.set_wait_time(selected_exercise.rep_time)
	
	$ActiveExercise.show()

func updateMoneyLabel(label):
	label.set_text("$" + str("%.2f" % Globals.money))

func openStore():
	updateMoneyLabel($Store/VerticalBox_Main/HorizontalBox_Top/Label_Money)
	$Store.show()

func receivedExerciseInfo():
	selected_exercise = $ExerciseSelect.selected_exercise
	setActiveExerciseUI()


func completedRep():
	Globals.money += selected_exercise.money_earned
	updateMoneyLabel($ActiveExercise/VerticalBox_Main/Label_Money)


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	updateMoneyLabel($Store/VerticalBox_Main/HorizontalBox_Top/Label_Money)
	$ExerciseSelect._on_Button_PullUp_tree_entered()
