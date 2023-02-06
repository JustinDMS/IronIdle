extends Control

signal supplement_taken

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
		if Globals.player.gym_units[item] == 0 or item == "None":
			continue
		else:
			var text = "x" + str(Globals.player.gym_units[item]) + " " + item
			var label = newLabel(text)
			deletion_array.append(label)
			units.add_child(label)
	
	for item in Globals.player.gym_equipment:
		if Globals.player.gym_equipment[item] == 0 or item == "None":
			continue
		else:
			var text = "x" + str(Globals.player.gym_equipment[item]) + " " + item
			var label = newLabel(text)
			deletion_array.append(label)
			equipment.add_child(label)
	
	for item in Globals.player.gym_supplements:
		if Globals.player.gym_supplements[item] == 0 or item == "None":
			continue
		else:
			var text = "x" + str(Globals.player.gym_supplements[item]) + " " + item
			var label = newLabel(text)
			deletion_array.append(label)
			supplements.add_child(label)


func newLabel(text):
	var label = Label.new()
	label.add_font_override("font", font)
	label.set_align(0)
	label.set_text(text)
	return label


func _on_Button_Exit_pressed():
	hide()


func _on_OptionButton_item_selected(index):
	# Indices
	# 1 - Caffeiene, 2 - Creatine, 3 - BCAA
	selected_supplement = $Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer3/HBoxContainer/OptionButton.get_item_text(index)


func _on_Button_TakeSupplement_pressed():
	if selected_supplement != null:
		
		var num_supplement = Globals.player.gym_supplements[selected_supplement]
		
		if num_supplement < 1:
			return
		
		else:
			Globals.player.gym_supplements[selected_supplement] = num_supplement - 1
			Globals.player.active_supplements[selected_supplement] = Globals.player.active_supplements[selected_supplement] + Globals.getSupplementCharges(selected_supplement) + Globals.getSponsorMeCharges(Globals.active_sponsor_tier)
			updateInventory()
			emit_signal("supplement_taken")
