extends Control

signal clicked_store
signal completed_rep

onready var chest_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/StrengthProgress_Chest
onready var shoulders_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/StrengthProgress_Shoulders
onready var back_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength1/StrengthProgress_Back
onready var core_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/StrengthProgress_Core
onready var quadriceps_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/StrengthProgress_Quadriceps
onready var hamstrings_progress = $VBox_Main/Panel/VBox_PlayerInfo/HBox_1/VBox_Strength2/StrengthProgress_Hamstrings


func _ready():
	$VBox_Main/HBox_Options/MenuButton.get_popup().connect("index_pressed", self, "optionSelected")


func initDisplay():
	chest_progress.initDisplay("Chest")
	shoulders_progress.initDisplay("Shoulders")
	back_progress.initDisplay("Back")
	core_progress.initDisplay("Core")
	quadriceps_progress.initDisplay("Quadriceps")
	hamstrings_progress.initDisplay("Hamstrings")


func updateProgress(muscle : String):
	match muscle:
		"Chest":
			chest_progress.updateProgress(muscle)
		"Shoulders":
			shoulders_progress.updateProgress(muscle)
		"Back":
			back_progress.updateProgress(muscle)
		"Core":
			core_progress.updateProgress(muscle)
		"Quadriceps":
			quadriceps_progress.updateProgress(muscle)
		"Hamstrings":
			hamstrings_progress.updateProgress(muscle)


func _on_Button_Store_pressed():
	emit_signal("clicked_store")


func _on_ActiveExercise_completed_rep():
	emit_signal("completed_rep")


func _on_TextureButton_Inventory_pressed():
	var scene = load("res://Scenes/Inventory.tscn")
	var instance = scene.instance()
	get_parent().add_child(instance)


func optionSelected(index):
	
	match index:
		0:
			var info_scene = load("res://Scenes/InfoPanel.tscn")
			add_child(info_scene.instance())
