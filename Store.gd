extends Control

signal clicked_return
signal purchase_made

func _ready():
	pass

func _on_Button_HighBar_pressed():
	
	if Globals.gym.has("High Bar"):
		print("Already owned")
		return
	else:
		Globals.makePurchase(5.00, Globals.gym, "High Bar")
		emit_signal("purchase_made")
		print(Globals.gym)

func _on_Button_Exit_pressed():
	hide()
	emit_signal("clicked_return")
