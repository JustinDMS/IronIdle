extends Control

signal clicked_return
signal purchase_made(type, item, amount)
signal experience_purchase_made(muscle)

var item
var price
var supplement_description
var muscle
var amount

onready var confirm_purchase = $ConfirmPurchase
onready var confirm_equipment_purchase = $ConfirmPurchaseEquipment

onready var pullupbar = $HBoxContainer/VBox_Units/HBoxContainer/Button_PullUpBar
onready var bench = $HBoxContainer/VBox_Units/HBoxContainer2/Button_Bench
onready var barbellrack = $HBoxContainer/VBox_Units/HBoxContainer3/Button_BarbellRack
onready var deadliftplatform = $HBoxContainer/VBox_Units/HBoxContainer4/Button_DeadliftPlatform

onready var dumbbells = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer/Button_Dumbbells
onready var barbell = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer2/Button_Barbell
onready var plates = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer3/Button_Plates
onready var ab_wheel = $HBoxContainer/VBox_Units/VBox_Equipment/HBoxContainer4/Button_AbWheel

onready var caffeine = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer/Button_Caffeine
onready var creatine = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer2/Button_Creatine
onready var bcaa = $HBoxContainer/VBox_Training/VBox_Supplements/HBoxContainer3/Button_BCAA

onready var base_prices = {
	pullupbar : 450.00,
	bench : 300.00,
	barbellrack : 250.00,
	deadliftplatform : 750.00,
	
	dumbbells : 60.00,
	barbell : 250.00,
	plates : 75.00,
	ab_wheel : 80.00,
	
	caffeine : 25.00,
	creatine : 35.00,
	bcaa : 30.00,
}
onready var prices = {
	pullupbar : 450.00,
	bench : 300.00,
	barbellrack : 250.00,
	deadliftplatform : 750.00,
	
	dumbbells : 60.00,
	barbell : 250.00,
	plates : 75.00,
	ab_wheel : 80.00,
	
	caffeine : 25.00,
	creatine : 35.00,
	bcaa : 30.00,
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
	"Pull-Up Bar" : "Bar used to perform pull-ups or otherwise hang from",
	"Bench" : "Flat bench used for a variety of exercises",
	"Barbell Rack" : "Holds the barbell",
	"Deadlift Platform" : "Sturdy platform built for slamming your weights while deadlifting",
	
	"Dumbbells" : "Used for unilateral training. Upgrade to gain extra money and Strength XP",
	"Barbell" : "Heavy-duty stainless steel bar for your heaviest lifts",
	"Plates" : "Barbell weight factored in. Upgrade to gain extra money and Strength XP",
	"Ab Wheel" : "Used for the Ab Wheel Rollout exercise. Perfect for humbling yourself",
	
	"Caffeine" : "-20% rep time for ",
	"Creatine" : "Double strength XP for ",
	"BCAA" : "Double proficiency XP for ",
}


func _ready():
	pass


func setPrices():
	for i in prices:
		i.set_text("$" + str(prices[i]))


func showConfirmPurchase(item_name : String, description : String, item_price : float, type : int):
	confirm_purchase.initPurchase(item_name, description, item_price, type)
	confirm_purchase.show()


func showEquipmentConfirmPurchase(item_name : String, description : String, cost : float):
	confirm_equipment_purchase.initEquipmentPurchase(item_name, description, cost)
	confirm_equipment_purchase.show()


func showUnitConfirmPurchase(item_name, description, cost):
	confirm_equipment_purchase.initUnitPurchase(item_name, description, cost)
	confirm_equipment_purchase.show()


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


func updateEquipmentPrices(equipment : String, item_node : Node):
	var tier = Globals.player.equipment_tier[equipment]
	var cost = base_prices[item_node]
	
	for _i in range(0, tier):
		cost = cost * 2
	
	prices[item_node] = cost
	item_node.set_text("$" + Globals.formatBigNumber(cost))


func purchaseMade(type, i, a):
	emit_signal("purchase_made", type, i, a)


# Units / / / / / / / / / / / / / / / / / / / /

func _on_Button_Exit_pressed():
	hide()
	emit_signal("clicked_return")


func _on_Button_PullUpBar_pressed():
	item = "Pull-Up Bar"
	price = prices[pullupbar]
	showUnitConfirmPurchase(item, descriptions[item], price)

func _on_Button_Bench_pressed():
	item = "Bench"
	price = prices[bench]
	showUnitConfirmPurchase(item, descriptions[item], price)

func _on_Button_BarbellRack_pressed():
	item = "Barbell Rack"
	price = prices[barbellrack]
	showUnitConfirmPurchase(item, descriptions[item], price)

func _on_Button_DeadliftPlatform_pressed():
	item = "Deadlift Platform"
	price = prices[deadliftplatform]
	showUnitConfirmPurchase(item, descriptions[item], price)

# Equipment / / / / / / / / / / / / / / / / / / / /

func _on_Button_Dumbbells_pressed():
	item = "Dumbbells"
	price = prices[dumbbells]
	showEquipmentConfirmPurchase(item, descriptions[item], price)

func _on_Button_Barbell_pressed():
	item = "Barbell"
	price = prices[barbell]
	showEquipmentConfirmPurchase(item, descriptions[item], price)

func _on_Button_Plates_pressed():
	item = "Plates"
	price = prices[plates]
	showEquipmentConfirmPurchase(item, descriptions[item], price)

func _on_Button_AbWheel_pressed():
	item = "Ab Wheel"
	price = prices[ab_wheel]
	showEquipmentConfirmPurchase(item, descriptions[item], price)

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
