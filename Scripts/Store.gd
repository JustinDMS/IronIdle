extends Control

signal clicked_return
signal purchase_made
signal experience_purchase_made(muscle)

var item
var price
var supplement_description
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

onready var base_prices = {
	pullupbar : 45.00,
	bench : 35.00,
	barbellrack : 45.00,
	deadliftplatform : 95.00,
	
	dumbbells : 30.00,
	barbell : 75.00,
	plates : 35.00,
	
	caffeine : 10.00,
	creatine : 20.00,
	bcaa : 15.00,
}
onready var prices = {
	pullupbar : 45.00,
	bench : 35.00,
	barbellrack : 45.00,
	deadliftplatform : 95.00,
	
	dumbbells : 30.00,
	barbell : 75.00,
	plates : 35.00,
	
	caffeine : 10.00,
	creatine : 20.00,
	bcaa : 15.00,
}
var base_discount = {
	"I" : 0.80,
	"II" : 0.65,
	"III" : 0.50,
}
var sponsor_discount = {
	"I" : 0.15,
	"II" : 0.20,
	"III" : 0.25,
}
var active_discount = {}
var descriptions = {
	"Pull-Up Bar" : "Bar used to perform pull-ups",
	"Bench" : "Flat bench used for variations of the bench press",
	"Barbell Rack" : "Holds the barbell",
	"Deadlift Platform" : "Sturdy platform built for slamming your weights while deadlifting",
	
	"Dumbbells" : "Lighter weights used for unilateral training",
	"Barbell" : "Heavy-duty stainless steel bar for your heaviest lifts",
	"Plates" : "Barbell's best friend. Iconic clanking sounds included",
	
	"Caffeine" : "-20% rep time for ",
	"Creatine" : "Double strength XP for ",
	"BCAA" : "Double proficiency XP for ",
}


func _ready():
	setPrices()


func setPrices():
	for i in prices:
		i.set_text("$" + str(prices[i]))


func showConfirmPurchase(item_name : String, description : String, item_price : float, type : int):
	confirm_purchase.initPurchase(item_name, description, item_price, type)
	confirm_purchase.show()


func updateDiscount(supplement, tier):
	
	prices[supplement] = base_prices[supplement]
	active_discount[supplement] = 1.0
	
	prices[supplement] = base_prices[supplement] * base_discount[tier]
	active_discount[supplement] = base_discount[tier]
	setPrices()


func setSponsorMeDiscount(tier):
	
	active_discount[caffeine] = active_discount[caffeine] - sponsor_discount[tier]
	active_discount[creatine] = active_discount[creatine] - sponsor_discount[tier]
	active_discount[bcaa] = active_discount[bcaa] - sponsor_discount[tier]
	
	prices[caffeine] = base_prices[caffeine] * active_discount[caffeine]
	prices[creatine] = base_prices[creatine] * active_discount[creatine]
	prices[bcaa] = base_prices[bcaa] * active_discount[bcaa]
	
	Globals.active_sponsor_tier = tier
	
	setPrices()

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
	supplement_description = descriptions[item] + str(Globals.getSupplementCharges(item) + Globals.getSponsorMeCharges(Globals.active_sponsor_tier)) + " reps"
	showConfirmPurchase(item, supplement_description, price, 2)


func _on_Button_Creatine_pressed():
	item = "Creatine"
	price = prices[creatine]
	supplement_description = descriptions[item] + str(Globals.getSupplementCharges(item) + Globals.getSponsorMeCharges(Globals.active_sponsor_tier)) + " reps"
	showConfirmPurchase(item, supplement_description, price, 2)


func _on_Button_BCAA_pressed():
	item = "BCAA"
	price = prices[bcaa]
	supplement_description = descriptions[item] + str(Globals.getSupplementCharges(item) + Globals.getSponsorMeCharges(Globals.active_sponsor_tier)) + " reps"
	showConfirmPurchase(item, supplement_description, price, 2)

# Levels / / / / / / / / / / / / / / / / / / / /

func _on_LineEdit_text_changed(new_text):
	amount = int(new_text)


func _on_OptionButton_item_selected(index):
	muscle = $HBoxContainer/VBox_Training/HBoxContainer4/OptionButton.get_item_text(index)


func _on_Button_XP_pressed():
	
	var checkamount : bool = amount != null and amount > 0
	
	if muscle != null and checkamount:
		if Globals.player.money >= amount:
			Globals.player.money -= amount
			Globals.gainExperience(muscle, amount)
			emit_signal("experience_purchase_made", muscle)
