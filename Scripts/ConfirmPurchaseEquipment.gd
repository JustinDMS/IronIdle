extends Control

signal purchased(type, item, amount)

var total_cost
var item_name
var type

func initEquipmentPurchase(item : String, description : String, cost : float):
	
	item_name = item
	total_cost = cost
	type = "Equipment"
	
	$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Description.set_text(description)
	$Panel/VBoxContainer/VBox_Spacing/HBoxContainer3/HBox_Cost/Label_Cost2.set_text(Globals.formatBigNumber(cost))
	
	match item:
		"Barbell":
			$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Item.set_text(item)
		"Dumbbells":
			$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Item.set_text(str(int(Globals.player.equipment_tier[item] + 1) * 10) + "lb " + item)
		"Plates":
			$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Item.set_text(item + " (" + getPlateNum() + "lbs)")
		"Ab Wheel":
			$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Item.set_text(item)


func initUnitPurchase(item : String, description : String, cost : float):
	
	item_name = item
	total_cost = cost
	type = "Unit"
	
	$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Item.set_text(item)
	$Panel/VBoxContainer/VBox_Spacing/VBoxContainer/Label_Description.set_text(description)
	$Panel/VBoxContainer/VBox_Spacing/HBoxContainer3/HBox_Cost/Label_Cost2.set_text(Globals.formatBigNumber(cost))


func getPlateNum():
	var tier = Globals.player.equipment_tier["Plates"] + 1
	var plate_num = 45 * tier
	return Globals.formatBigNumber(plate_num * 2 + 45)


func _on_Button_Cancel_pressed():
	hide()


func _on_Button_Purchase_pressed():
	
	if Globals.player.money < total_cost:
		print("Not enough money")
	
	else:
		
		match type:
			"Equipment":
				
				if Globals.player.gym_equipment[item_name] == false:
					Globals.player.gym_equipment[item_name] = true
					if item_name.match("Barbell") == false and item_name.match("Ab Wheel") == false:
						Globals.player.equipment_tier[item_name] = Globals.player.equipment_tier[item_name] + 1
				
				elif item_name.match("Barbell") == false and item_name.match("Ab Wheel") == false:
					Globals.player.equipment_tier[item_name] = Globals.player.equipment_tier[item_name] + 1
				
				elif Globals.player.gym_equipment[item_name] == true:
					print("Already owned")
					return
			
			"Unit":
				
				if Globals.player.gym_units[item_name] == true:
					print("Already owned")
					return
					
				else: Globals.player.gym_units[item_name] = true
		
		Globals.player.money -= total_cost
		emit_signal("purchased", type, item_name, 1)
		_on_Button_Cancel_pressed()
