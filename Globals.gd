extends Node

# Exercise info
var pushup = load("res://Exercises/PushUp.tres")
var situp = load("res://Exercises/SitUp.tres")
var pullup = load("res://Exercises/PullUp.tres")
var bodyweight_squat = load("res://Exercises/BodyweightSquat.tres")

var benchpress = load("res://Exercises/BenchPress.tres")
var overheadpress = load("res://Exercises/OverheadPress.tres")
var squat = load("res://Exercises/Squat.tres")
var deadlift = load("res://Exercises/Deadlift.tres")

# Player variables
var money := 0.00
var gym = ["None",]
var equipment = ["None",]


func _ready():
	pass

func makePurchase(amount, type, item):
	if amount > money:
		print("Insufficient balance")
		return
	else:
		money = money - amount
		type.append(item)
		print(item + " purchased")
		saveGame()

func saveGame():
	
	var save_dict = {
		"money" : money,
		"gym" : gym,
		"equipment" : equipment,
	}
	
	var save_game = File.new()
	save_game.open("res://savegame.save", File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	print("Game saved")

func loadGame():
	
	var save_game = File.new()
	save_game.open("res://savegame.save", File.READ)
	var node_data = parse_json(save_game.get_line())
	
	money = node_data["money"]
	gym = node_data["gym"]
	equipment = node_data["equipment"]
	
	save_game.close()
	print("Game loaded")
