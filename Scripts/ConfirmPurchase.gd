extends Control

signal purchased

var item_name
var item_price
var amount = 1
var num_owned
var type = ["gym_units", "gym_equipment", "gym_supplements"]
var item_type
var total_cost

func initPurchase(item : String, description : String, price : float, item_type_index : int):
	
	item_name = item
	item_price = price
	item_type = type[item_type_index]
	num_owned = Globals.player[item_type][item]
	
	$Panel/VBoxContainer/VBox_Spacing/Label_Item.set_text(item_name)
	$Panel/VBoxContainer/VBox_Spacing/Label_Description.set_text(description)
	
	updateCost(item_price)
	updateOwned(num_owned)


func updateCost(price):
	total_cost = price * amount
	$Panel/VBoxContainer/VBox_Spacing/HBoxContainer3/HBox_Cost/Label_Cost2.set_text(str("%.2f" % total_cost))


func updateOwned(owned):
	$Panel/VBoxContainer/VBox_Spacing/HBoxContainer4/Label_Owned.set_text("x" + str(owned + amount))


func _on_Button_Purchase_pressed():
	
	if Globals.player.money < total_cost:
		print("Not enough money")
	
	else:
		Globals.player[item_type][item_name] = amount
		Globals.player.money -= total_cost
		emit_signal("purchased")
		_on_Button_Cancel_pressed()


func _on_Button_Cancel_pressed():
	amount = 1
	$Panel/VBoxContainer/VBox_Spacing/HBoxContainer2/HBox_Amount/LineEdit_Amount.set_text(str(amount))
	hide()


func _on_LineEdit_Amount_text_changed(new_text):

	amount = float(new_text)
	var checkamount : bool = amount != null and amount > 0
	
	if checkamount:
		updateCost(item_price)
		updateOwned(num_owned)
