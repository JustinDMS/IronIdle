extends Control

signal clicked_return
signal purchase_made

func _ready():
	pass

func attemptPurchase(type, item:String, amount:float):
	if type.has(item):
		print("Already owned")
		return
	else:
		Globals.makePurchase(amount, type, item)
		emit_signal("purchase_made")
		print(type)


func _on_Button_Exit_pressed():
	hide()
	emit_signal("clicked_return")


func _on_Button_HighBar_pressed():
	attemptPurchase(Globals.gym, "High Bar", 5.00)


func _on_Button_Bench_pressed():
	attemptPurchase(Globals.gym, "Bench", 7.00)


func _on_Button_Rack_pressed():
	attemptPurchase(Globals.gym, "Rack", 8.15)


func _on_Button_Platform_pressed():
	attemptPurchase(Globals.gym, "Deadlift Platform", 10.50)


func _on_Button_Plates_pressed():
	attemptPurchase(Globals.equipment, "Plates", 6.35)
