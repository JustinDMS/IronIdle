extends Node

var selected_exercise
var money_earned


func _ready():
	Globals.loadGame()
	updateInventory()
	updateUnlockedExercises()

func updateInventory():
	var inventory_gym : String
	var inventory_equipment : String
	var total_items_gym = len(Globals.gym)
	var total_items_equipment = len(Globals.equipment)
	var count = 1
	
	for i in Globals.gym:
		if i == "None":
			pass
		elif count == total_items_gym:
			inventory_gym = inventory_gym + str(i)
		else:
			inventory_gym = inventory_gym + str(i) + ", "
		count += 1
	
	count = 1
	
	for i in Globals.equipment:
		if i == "None":
			pass
		elif count == total_items_equipment:
			inventory_equipment = inventory_equipment + str(i)
		else:
			inventory_equipment = inventory_equipment + str(i) + ", "
		count += 1
	
	$ExerciseSelect/VerticalBox_Main/VerticalBox_Store/Label_InventoryGym.set_text(inventory_gym)
	$ExerciseSelect/VerticalBox_Main/VerticalBox_Store/Label_InventoryEquipment.set_text(inventory_equipment)


func updateUnlockedExercises():
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Calisthenic/Button_PushUp, Globals.pushup)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Calisthenic/Button_SitUp, Globals.situp)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Calisthenic/Button_BodyweightSquat, Globals.bodyweight_squat)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Calisthenic/Button_PullUp, Globals.pullup)
	
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Weighted/Button_BenchPress, Globals.benchpress)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Weighted/Button_OverheadPress, Globals.overheadpress)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Weighted/Button_Squat, Globals.squat)
	$ExerciseSelect.determineUnlocked($ExerciseSelect/VerticalBox_Main/VerticalBox_Weighted/Button_Deadlift, Globals.deadlift)


func setActiveExerciseUI():
	$ActiveExercise/VerticalBox_Main/Label_ExerciseName.set_text(selected_exercise.exercise_name)
	
	$ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime.set_text(str(selected_exercise.rep_time) + "s")
	$ActiveExercise/RepTimer.set_wait_time(selected_exercise.rep_time)
	
	calculateMoneyEarned(selected_exercise.rep_time)
	$ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned.set_text("$" + money_earned)
	updateMoneyLabel($ActiveExercise/VerticalBox_Main/Label_Money)
	
	$ActiveExercise.show()


func updateMoneyLabel(label):
	label.set_text("$" + str("%.2f" % Globals.money))


func calculateMoneyEarned(time):
	money_earned = str("%.2f" % (pow(time, 1.75)/100))


# Signals / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

func openStore():
	updateMoneyLabel($Store/VerticalBox_Main/HorizontalBox_Top/Label_Money)
	$Store.show()


func receivedExerciseInfo():
	if selected_exercise == $ExerciseSelect.selected_exercise:
		setActiveExerciseUI()
	else:
		$ActiveExercise.stopExercise()
		selected_exercise = $ExerciseSelect.selected_exercise
		setActiveExerciseUI()


func completedRep():
	Globals.money += float(money_earned)
	updateMoneyLabel($ActiveExercise/VerticalBox_Main/Label_Money)
	updateMoneyLabel($Store/VerticalBox_Main/HorizontalBox_Top/Label_Money)


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade():
	updateMoneyLabel($Store/VerticalBox_Main/HorizontalBox_Top/Label_Money)
	updateInventory()
	updateUnlockedExercises()






# Destructor
func _on_Main_tree_exiting():
	Globals.saveGame()
