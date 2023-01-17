extends Control

signal clicked_return
signal purchase_made
signal experience_purchase_made(muscle)

var type = ["gym_units", "gym_equipment"]
var item
var price

var muscle
var amount

onready var pullupbar = $HBoxContainer/VBox_Units/HBoxContainer/Button_PullUpBar
onready var bench = $HBoxContainer/VBox_Units/HBoxContainer2/Button_Bench
onready var barbellrack = $HBoxContainer/VBox_Units/HBoxContainer3/Button_BarbellRack
onready var deadliftplatform = $HBoxContainer/VBox_Units/HBoxContainer4/Button_DeadliftPlatform

onready var dumbbells = $HBoxContainer/VBox_Equipment/HBoxContainer/Button_Dumbbells
onready var barbell = $HBoxContainer/VBox_Equipment/HBoxContainer2/Button_Barbell
onready var plates = $HBoxContainer/VBox_Equipment/HBoxContainer3/Button_Plates

onready var prices = {
	pullupbar : 45,
	bench : 90,
	barbellrack : 60,
	deadliftplatform : 200,
	
	dumbbells : 25,
	barbell : 125,
	plates : 75,
}

func _ready():
	setPrices()


func setPrices():
	for i in prices:
		i.set_text("$" + str(prices[i]))


func checkPurchase(item_type : String, item_purchase : String, item_price : float): # type = unit, equipment, or level
	
	if Globals.player[item_type].has(item_purchase):
		print("Already owned")
	
	elif Globals.player.money < item_price:
		print("Not enough money")

	else:
		Globals.player[item_type].append(item_purchase)
		Globals.player.money -= item_price
		emit_signal("purchase_made")
		print("Purchased!")


# Units / / / / / / / / / / / / / / / / / / / /

func _on_Button_Exit_pressed():
	hide()
	emit_signal("clicked_return")


func _on_Button_PullUpBar_pressed():
	item = "Pull-Up Bar"
	price = prices[pullupbar]
	checkPurchase(type[0], item, price)


func _on_Button_Bench_pressed():
	item = "Bench"
	price = prices[bench]
	checkPurchase(type[0], item, price)

func _on_Button_BarbellRack_pressed():
	item = "Barbell Rack"
	price = prices[barbellrack]
	checkPurchase(type[0], item, price)

func _on_Button_DeadliftPlatform_pressed():
	item = "Deadlift Platform"
	price = prices[deadliftplatform]
	checkPurchase(type[0], item, price)

# Equipment / / / / / / / / / / / / / / / / / / / /

func _on_Button_Dumbbells_pressed():
	item = "Dumbbells"
	price = prices[dumbbells]
	checkPurchase(type[1], item, price)

func _on_Button_Barbell_pressed():
	item = "Barbell"
	price = prices[dumbbells]
	checkPurchase(type[1], item, price)

func _on_Button_Plates_pressed():
	item = "Plates"
	price = prices[plates]
	checkPurchase(type[1], item, price)

# Levels / / / / / / / / / / / / / / / / / / / /

func _on_LineEdit_text_changed(new_text):
	amount = int(new_text)


func _on_OptionButton_item_selected(index):
	muscle = $HBoxContainer/VBox_Levels/HBoxContainer4/OptionButton.get_item_text(index)


func _on_Button_XP_pressed():
	
	var checkamount : bool = amount != null and amount > 0
	
	if muscle != null and checkamount:
		if Globals.player.money >= amount:
			Globals.player.money -= amount
			Globals.gainExperience(muscle, amount)
			emit_signal("experience_purchase_made", muscle)
