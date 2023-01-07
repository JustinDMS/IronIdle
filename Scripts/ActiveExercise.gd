extends Control

signal completed_rep

var rep_progress = 0.0

func _ready():
	pass

func _process(_delta):
	if $RepTimer.is_stopped() == false:
		calculateProgress()
		$VerticalBox_Bottom/ProgressBar_Rep.set_value(rep_progress)

func calculateProgress():
	rep_progress = 1 - $RepTimer.get_time_left() / $RepTimer.get_wait_time()

func stopExercise():
	$RepTimer.stop()
	rep_progress = 0
	$VerticalBox_Bottom/ProgressBar_Rep.set_value(rep_progress)
	
	Globals.saveGame()

func _on_Button_Start_pressed():
	stopExercise()
	$RepTimer.start()


func _on_Button_End_pressed():
	stopExercise()

func _on_RepTimer_timeout():
	emit_signal("completed_rep")
