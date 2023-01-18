extends Control

signal clicked_return
signal purchase_made
signal experience_purchase_made(muscle)

var item
var price

var muscle
var amount

onready var confirm_purchase = $ConfirmPurchase

onready var pullupbar = $HBoxContainer/VBox_Units/HBoxContainer/Button_PullUpBar
onready var bench = $HBoxContainer/VBox_Units/HBoxContainer2/Button_Bench
onready var barbellrack = $HBoxContainer/VBox_Units/HBoxContainer3/Button_BarbellRack
onready var deadliftplatform = $HBoxContainer/VBox_Units/HBoxContainer4/Button_DeadliftPlatform

onready var dumbbells = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer/Button_Dumbbells
onready var barbell = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer2/Button_Barbell
onready var plates = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer3/Button_Plates

onready var caffeine = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer/Button_Caffeine
onready var creatine = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer2/Button_Creatine
onready var bcaa = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer3/Button_BCAA

onready var prices = {
	pullupbar : 45.00,
	bench : 90.00,
	barbellrack : 60.00,
	deadliftplatform : 200.00,
	
	dumbbells : 30.00,
	barbell : 125.00,
	plates : 75.00,
	
	caffeine : 10.00,
	creatine : 15.00,
	bcaa : 15.00,
}

var descriptions = {
	"Pull-Up Bar" : "Bar used to perform pull-ups",
	"Bench" : "Flat bench used for variations of the bench press",
	"Barbell Rack" : "Holds the barbell",
	"Deadlift Platform" : "Sturdy platform built for slamming your weights while deadlifting",
	
	"Dumbbells" : "Lighter weights used for unilateral training",
	"Barbell" : "Heavy-duty stainless steel bar for your heaviest lifts",
	"Plates" : "Barbell's best friend. Iconic clanking sounds included",
	
	"Caffeine" : "Provides -20% to your rep time",
	"Creatine" : "Provides 2x the strength xp",
	"BCAA" : "Provides 2x the proficiency xp",
}


func _ready():
	setPrices()


func setPrices():
	for i in prices:
		i.set_text("$" + str(prices[i]))


func showConfirmPurchase(item_name : String, description : String, item_price : float, type : int):
	confirm_purchase.initPurchase(item_name, description, item_price, type)
	confirm_purchase.show()


func purchaseMade():
	emit_signal("purchase_made")

# Units / / / / / / / / / / / / / / / / / / / /

func _on_Button_Exit_pressed():
	hide()
	emit_signal("clicked_return")


func _on_Button_PullUpBar_pressed():
	item = "Pull-Up Bar"
	price = prices[pullupbar]
	showConfirmPurchase(item, descriptions[item], price, 0)

func _on_Button_Bench_pressed():
	item = "Bench"
	price = prices[bench]
	showConfirmPurchase(item, descriptions[item], price, 0)

func _on_Button_BarbellRack_pressed():
	item = "Barbell Rack"
	price = prices[barbellrack]
	showConfirmPurchase(item, descriptions[item], price, 0)

func _on_Button_DeadliftPlatform_pressed():
	item = "Deadlift Platform"
	price = prices[deadliftplatform]
	showConfirmPurchase(item, descriptions[item], price, 0)

# Equipment / / / / / / / / / / / / / / / / / / / /

func _on_Button_Dumbbells_pressed():
	item = "Dumbbells"
	price = prices[dumbbells]
	showConfirmPurchase(item, descriptions[item], price, 1)

func _on_Button_Barbell_pressed():
	item = "Barbell"
	price = prices[dumbbells]
	showConfirmPurchase(item, descriptions[item], price, 1)

func _on_Button_Plates_pressed():
	item = "Plates"
	price = prices[plates]
	showConfirmPurchase(item, descriptions[item], price, 1)

# Supplements / / / / / / / / / / / / / / / / / / / /

func _on_Button_Caffeine_pressed():
	item = "Caffeine"
	price = prices[caffeine]
	showConfirmPurchase(item, descriptions[item], price, 2)


func _on_Button_Creatine_pressed():
	item = "Creatine"
	price = prices[creatine]
	showConfirmPurchase(item, descriptions[item], price, 2)


func _on_Button_BCAA_pressed():
	item = "BCAA"
	price = prices[bcaa]
	showConfirmPurchase(item, descriptions[item], price, 2)

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
