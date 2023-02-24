extends Control

signal supplement_taken(num, type)

onready var units = $Panel/VBoxContainer/HBoxContainer/VBox_Units
onready var equipment = $Panel/VBoxContainer/HBoxContainer/Vbox2/MarginContainer/VBox_Equipment
onready var supplements = $Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements
onready var containers = [units, equipment, supplements]
var selected_supplement

var font = preload("res://Fonts/SmallText.tres")

var dictionary_names = ["gym_units", "gym_equipment", "gym_supplements"]
var deletion_array = []


func _ready():
	pass


func updateInventory():
	
	for node in deletion_array:
		if is_instance_valid(node):
			node.queue_free()
	
	for item in Globals.player.gym_units:
		if Globals.player.gym_units[item] == false or item == "None":
			continue
		else:
			var label = newLabel(item)
			deletion_array.append(label)
			units.add_child(label)
	
	for item in Globals.player.gym_equipment:
		if Globals.player.gym_equipment[item] == false or item == "None":
			continue
		else:
			match item:
				"Dumbbells":
					var text = str(Globals.player.equipment_tier[item] * 10) + "lb " + item
					var label = newLabel(text)
					deletion_array.append(label)
					equipment.add_child(label)
				"Plates":
					var text = item + " (" + str(getPlateNum()) + "lbs)"
					var label = newLabel(text)
					deletion_array.append(label)
					equipment.add_child(label)
				"Barbell":
					var text = item
					var label = newLabel(text)
					deletion_array.append(label)
					equipment.add_child(label)
				"Ab Wheel":
					var text = item
					var label = newLabel(text)
					deletion_array.append(label)
					equipment.add_child(label)
	
	for item in Globals.player.gym_supplements:
		if Globals.player.gym_supplements[item] == 0 or item == "None":
			match item:
				"Caffeine":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Caffeine.set_visible(false)
				"Creatine":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Creatine.set_visible(false)
				"BCAA":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_BCAA.set_visible(false)
		else:
			var text = "x" + Globals.formatBigNumber(Globals.player.gym_supplements[item]) + " " + item
			match item:
				"Caffeine":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Caffeine/Label_Caffeine.set_text(text)
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Caffeine.set_visible(true)
				"Creatine":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Creatine/Label_Creatine.set_text(text)
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_Creatine.set_visible(true)
				"BCAA":
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_BCAA/Label_BCAA.set_text(text)
					$Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements/VBox_BCAA.set_visible(true)


func newLabel(text):
	var label = Label.new()
	label.add_font_override("font", font)
	label.set_align(0)
	label.set_text(text)
	return label


func getPlateNum():
	var tier = Globals.player.equipment_tier["Plates"]
	var plate_num = 45 * tier
	return Globals.formatBigNumber(plate_num * 2 + 45)


func takeSupplement(supplement : String):
	
	var current_supplement_amount = Globals.player.gym_supplements[supplement]

	if current_supplement_amount < 1:
		return
	
	else:
		var charge_amount = Globals.getSupplementCharges(supplement) + Globals.getSponsorMeCharges(Globals.active_sponsor_tier)
		var charges_added = current_supplement_amount * charge_amount
		Globals.player.active_supplements[supplement] = Globals.player.active_supplements[supplement] + charges_added
		Globals.player.gym_supplements[supplement] = 0
		updateInventory()
		emit_signal("supplement_taken", charges_added, supplement)


func _on_Button_Exit_pressed():
	hide()


func _on_Caffeine_TakeAll_pressed():
	takeSupplement("Caffeine")


func _on_Creatine_TakeAll_pressed():
	takeSupplement("Creatine")


func _on_BCAA_TakeAll_pressed():
	takeSupplement("BCAA")
