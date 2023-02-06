extends Control

var button

func disableButton():
	$HBoxContainer/Button_Challenge.set_disabled(true)


func setButtonText(text):
	button = $HBoxContainer/Button_Challenge
	button.set_text(text)
