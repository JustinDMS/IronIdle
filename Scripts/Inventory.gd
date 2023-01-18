extends Control

onready var units = $Panel/VBoxContainer/HBoxContainer/VBox_Units
onready var equipment = $Panel/VBoxContainer/HBoxContainer/Vbox2/MarginContainer/VBox_Equipment
onready var supplements = $Panel/VBoxContainer/HBoxContainer/Vbox3/MarginContainer2/VBox_Supplements
onready var containers = [units, equipment, supplements]

var font = preload("res://Fonts/SmallText.tres")

var array_names = ["gym_units", "gym_equipment", "gym_supplements"]
var temp_array = []

func _ready():
	pass


func updateInventory():
	
	for num in range(3):
		for item in Globals.player[array_names[num]]:
		
			if item == "None":
				continue
			
			var text = str("x" + str(Globals.player[array_names[num]].count(item)) + " " + item)
		
			if temp_array.has(text):
				continue
			else:
				temp_array.append(text)
	
		addToInventory(containers[num])


func addToInventory(container):
	
	for item in temp_array:
		var label = newLabel(item)
		container.add_child(label)
	
	temp_array = []


func newLabel(text):
	var label = Label.new()
	label.add_font_override("font", font)
	label.set_align(0)
	label.set_text(text)
	return label


func _on_Button_Exit_pressed():
	hide()
