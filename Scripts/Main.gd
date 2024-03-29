extends Node

var selected_exercise
var money_earned
var strength_earned
var proficiency_earned = 1
var exercise_dict = {}
var last_interface

var has_caffeine : bool
var has_creatine : bool
var has_bcaa : bool

var show_strength : bool
var show_proficiency : bool
var show_money : bool

onready var player_balance = $SidePanel/VBox_Main/Panel/VBox_PlayerInfo/PlayerBalance
onready var caffeine_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/HBoxContainer/VBoxContainer/Label_Caffeine
onready var creatine_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/HBoxContainer/VBoxContainer/Label_Creatine
onready var bcaa_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/HBoxContainer/VBoxContainer/Label_BCAA


func _ready():
	Globals.loadGame()
	player_balance.updateBalance()
	$SidePanel.initDisplay()
	$SidePanel/Inventory.updateInventory()
	$ExerciseSelect.fillGrid()
	makeExerciseDict()
	buildChallengeList()
	applyCompletedChallengeBuff()
	updateStore()
	applySettings()


func setActiveExerciseUI():
	
	var exercise_name_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Main/Label_ExerciseName
	var rep_time_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_RepTime
	var rep_timer = $SidePanel/VBox_Main/Panel2/ActiveExercise/RepTimer
	var money_earned_label = $SidePanel/VBox_Main/Panel2/ActiveExercise/VerticalBox_Bottom/HorizonatlBox_Info/Label_MoneyEarned
	
	if selected_exercise == null:
		return
	
	else:
		
		var strength = Globals.player.strength_level[selected_exercise.muscle_groups]
		var proficiency = Globals.player.proficiency_level[selected_exercise.exercise_name]
		var rep_time
		money_earned = getMoney(Globals.calculateMoneyEarned(proficiency, selected_exercise.rep_time))
		
		if Globals.player.active_supplements["Creatine"] > 0:
			creatine_label.set_text("Creatine: " + getFormattedSupplementNumber("Creatine"))
			has_creatine = true
			strength_earned = getStrengthXP()
		else:
			strength_earned = getStrengthXP()
			creatine_label.set_text("Creatine: 0")
			has_creatine = false
		
		if Globals.player.active_supplements["Caffeine"] > 0:
			rep_time = str(float(Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)) * 0.8)
			caffeine_label.set_text("Caffeine: " + getFormattedSupplementNumber("Caffeine"))
			has_caffeine = true
		else:
			rep_time = Globals.calculateRepTime(strength, proficiency, selected_exercise.rep_time)
			caffeine_label.set_text("Caffeine: 0")
			has_caffeine = false
		
		if Globals.player.active_supplements["BCAA"] > 0:
			proficiency_earned = getProficiencyXP(selected_exercise) * 2
			bcaa_label.set_text("BCAA: " + getFormattedSupplementNumber("BCAA"))
			has_bcaa = true
		else:
			proficiency_earned = getProficiencyXP(selected_exercise)
			bcaa_label.set_text("BCAA: 0")
			has_bcaa = false
		
		exercise_name_label.set_text(selected_exercise.exercise_name)
		rep_time_label.set_text(rep_time + "s")
		rep_timer.set_wait_time(float(rep_time))
		money_earned_label.set_text("$" + str(money_earned))


func checkSupplements():
	
	var amount : int
	
	if has_caffeine == true:
		amount = Globals.player.active_supplements["Caffeine"]
		Globals.player.active_supplements["Caffeine"] = amount - 1
		updateSupplementsUsed("Caffeine")
		caffeine_label.set_text("Caffeine: " + getFormattedSupplementNumber("Caffeine"))
		if Globals.player.active_supplements["Caffeine"] < 1:
			has_caffeine = false
			setActiveExerciseUI()
	
	if has_creatine == true:
		amount = Globals.player.active_supplements["Creatine"]
		Globals.player.active_supplements["Creatine"] = amount - 1
		updateSupplementsUsed("Creatine")
		creatine_label.set_text("Creatine: " + getFormattedSupplementNumber("Creatine"))
		if Globals.player.active_supplements["Creatine"] < 1:
			has_creatine = false
			setActiveExerciseUI()
	
	if has_bcaa == true:
		amount = Globals.player.active_supplements["BCAA"]
		Globals.player.active_supplements["BCAA"] = amount - 1
		updateSupplementsUsed("BCAA")
		bcaa_label.set_text("BCAA: " + getFormattedSupplementNumber("BCAA"))
		if Globals.player.active_supplements["BCAA"] < 1:
			has_bcaa = false
			setActiveExerciseUI()


func getFormattedSupplementNumber(supplement : String):
	return Globals.formatBigNumber(Globals.player.active_supplements[supplement])


func updateSupplementsUsed(supplement):
	Globals.player.supplements_used[supplement] = Globals.player.supplements_used[supplement] + 1


func updateProficiencyProgress(exercise):
	if is_instance_valid(exercise_dict[exercise.exercise_name]):
		exercise_dict[exercise.exercise_name].updateProgress(exercise)


func experiencePurchased(muscle_group):
	$SidePanel.updateProgress(muscle_group)


func refreshExercisePanels(): # To update the dropdown menu on strength or proficiency level up
	$ExerciseSelect.applyFilter()


func buildChallengeList():
	$ChallengesDisplay.buildChallengeList()


func applyCompletedChallengeBuff():
	
	for c in Globals.all_challenges:
		if Globals.player.challenge_progress[c._name]: # If challenge is completed ie True
			match c.series_name:
				"No Imbalances":
					continue
				"Favorite Muscle":
					match c.series_position:
						1:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.Creatine = Globals.player.gym_supplements.Creatine + 10
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						2:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.Creatine = Globals.player.gym_supplements.Creatine + 20
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						3:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.Creatine = Globals.player.gym_supplements.Creatine + 30
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						4:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.Creatine = Globals.player.gym_supplements.Creatine + 40
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						5:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.Creatine = Globals.player.gym_supplements.Creatine + 50
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
				"Favorite Exercise":
					match c.series_position:
						1:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.BCAA = Globals.player.gym_supplements.BCAA + 15
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						2:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.BCAA = Globals.player.gym_supplements.BCAA + 25
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						3:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.BCAA = Globals.player.gym_supplements.BCAA + 40
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
						4:
							if checkSupplementsClaimed(c._name):
								Globals.player.gym_supplements.BCAA = Globals.player.gym_supplements.BCAA + 50
								Globals.player.supplement_challenge_claimed[c._name] = true
								$SidePanel/Inventory.updateInventory()
				"Need a Boost":
					match c.series_position:
						1:
							$Store.updateDiscount($Store.caffeine, "I")
						2:
							$Store.updateDiscount($Store.caffeine, "II")
						3:
							$Store.updateDiscount($Store.caffeine, "III")
				"Gain Train":
					match c.series_position:
						1:
							$Store.updateDiscount($Store.creatine, "I")
						2:
							$Store.updateDiscount($Store.creatine, "II")
						3:
							$Store.updateDiscount($Store.creatine, "III")
				"Focus on Form":
					match c.series_position:
						1:
							$Store.updateDiscount($Store.bcaa, "I")
						2:
							$Store.updateDiscount($Store.bcaa, "II")
						3:
							$Store.updateDiscount($Store.bcaa, "III")
				"Sponsor Me":
					match c.series_position:
						1:
							if not Globals.player.challenge_progress["Sponsor Me II"]:
								$Store.setSponsorMeDiscount("I")
							else:
								print("Sponsor Me II unlocked, skipped applying I")
						2:
							if not Globals.player.challenge_progress["Sponsor Me III"]:
								$Store.setSponsorMeDiscount("II")
							else:
								print("Sponsor Me III unlocked, skipped applying II")
						3:
							$Store.setSponsorMeDiscount("III")


func checkSupplementsClaimed(challenge_name):
	if not Globals.player.supplement_challenge_claimed[challenge_name]:
		return true
	else: return false


func getProficiencyXP(exercise):
	if Globals.player.challenge_progress["No Imbalances V"]:
		return getBaseProficiencyXP(exercise) + 5
	elif Globals.player.challenge_progress["No Imbalances IV"]:
		return getBaseProficiencyXP(exercise) + 4
	elif Globals.player.challenge_progress["No Imbalances III"]:
		return getBaseProficiencyXP(exercise) + 3
	elif Globals.player.challenge_progress["No Imbalances II"]:
		return getBaseProficiencyXP(exercise) + 2
	elif Globals.player.challenge_progress["No Imbalances I"]:
		return getBaseProficiencyXP(exercise) + 1
	else:
		return getBaseProficiencyXP(exercise)


func getBaseProficiencyXP(exercise):
	
	var level = Globals.player.proficiency_level[exercise.exercise_name]
	
	if level < 5:
		return 1
	elif level >= 5 and level < 10:
		return 2
	elif level >= 10 and level < 15:
		return 3
	elif level >= 15:
		return 4


func getStrengthXP():
	
	# Equipment Tier Check
	if selected_exercise.equipment_req_1 == "Dumbbells":
		strength_earned = selected_exercise.base_strength + Globals.player.equipment_tier["Dumbbells"] - 1
	
	elif selected_exercise.equipment_req_2 == "Plates":
		strength_earned = selected_exercise.base_strength + Globals.player.equipment_tier["Plates"] - 1
	
	else:
		strength_earned = selected_exercise.base_strength
	
	# Supplement Check
	if has_creatine:
		strength_earned = strength_earned * 2
	
	return strength_earned


func getMoney(base):
	
	# Equipment Tier Check
	if selected_exercise.equipment_req_1 == "Dumbbells":
		
		var tier = Globals.player.equipment_tier["Dumbbells"] - 1
		tier = tier * 0.1
		var bonus = str("%.2f" % (float(base) * tier))
		money_earned = float(base) + float(bonus)
	
	elif selected_exercise.equipment_req_2 == "Plates":
		
		var tier = Globals.player.equipment_tier["Plates"] - 1
		tier = tier * 0.1
		var bonus = str("%.2f" % (float(base) * tier))
		money_earned = float(base) + float(bonus)
	
	else:
		money_earned = base
	
	return money_earned


func updateStore():
	$Store.setPrices()
	$Store.updateEquipmentPrices("Dumbbells", $Store.dumbbells)
	$Store.updateEquipmentPrices("Plates", $Store.plates)


func proficiencyMaxOut(exercise):
	exercise_dict[exercise].setMaxOut()


func applySettings():
	show_strength = Globals.player.settings["Strength XP"]
	show_proficiency = Globals.player.settings["Proficiency XP"]
	show_money = Globals.player.settings["Money"]
	
	$Settings/Panel/VBoxContainer/MarginContainer/VBoxContainer/CheckBox_StrengthXP.set_pressed(show_strength)
	$Settings/Panel/VBoxContainer/MarginContainer/VBoxContainer/CheckBox_ProficiencyXP.set_pressed(show_proficiency)
	$Settings/Panel/VBoxContainer/MarginContainer/VBoxContainer/CheckBox_Money.set_pressed(show_money)


func showMilestones(muscle : String):
	$Milestones.initMilestoneDisplay(muscle)
	$Milestones.show()


func displayBigPopup(texture, text : String, is_strength : bool, exercise_name):
	$PopupManager.createBigPopup(texture, text, is_strength, exercise_name)


# Signals


func openStore():
	$ExerciseSelect.hide()
	$ChallengesDisplay.hide()
	$Store.show()


func receivedExerciseInfo():
	$SidePanel/VBox_Main/Panel2/Panel2_Cover.hide()
	
	if selected_exercise == $ExerciseSelect.selected_exercise:
		setActiveExerciseUI()
	else:
		$SidePanel/VBox_Main/Panel2/ActiveExercise.stopExercise()
		selected_exercise = $ExerciseSelect.selected_exercise
		setActiveExerciseUI()


func makeExerciseDict():
	
	for i in $ExerciseSelect/VBox_Main/ScrollContainer/GridContainer.get_children():
		var temp = i.find_node("ProficiencyProgress")
		if is_instance_valid(temp):
			exercise_dict[temp.exercise.exercise_name] = temp
	
	$ExerciseSelect/VBox_Main/ScrollContainer/GridContainer.add_child(Control.new())

func completedRep():
	Globals.player.money += float(money_earned)
	player_balance.updateBalance()

	Globals.gainExperience(selected_exercise.muscle_groups, strength_earned)
	$SidePanel.updateProgress(selected_exercise.muscle_groups)

	Globals.gainProficiencyExperience(selected_exercise.exercise_name, proficiency_earned)
	updateProficiencyProgress(selected_exercise)
	
	checkSupplements()
	
	if show_strength:
		$PopupManager.createPopup(Globals.muscle_icons_small[selected_exercise.muscle_groups], str(strength_earned) + "xp")
	if show_proficiency:
		$PopupManager.createPopup(Globals.proficiency_icon, str(proficiency_earned) + "xp")
	if show_money:
		$PopupManager.createPopup(Globals.money_icon, str(money_earned))
	
	var instance = get_node_or_null("ChallengesDisplay/MarginContainer/VBoxContainer/HBoxContainer/VBox_Details/ChallengeDetails")
	if is_instance_valid(instance):
		instance.updateProgressBar()
		instance.determineCanClaim(instance.selected_challenge)


func returnToExerciseSelect():
	$ExerciseSelect.show()


func storePurchaseMade(type, item, amount):
	
	match type:
		"Unit":
			$PopupManager.createPopup(load("res://Art/UnitIcon.png"), item)
		"Equipment":
			$PopupManager.createPopup(load("res://Art/MachineIcon.png"), item)
		"Supplement":
			$PopupManager.createPopup(Globals.supplement_icons[item], Globals.formatBigNumber(amount) + " " + item)
	
	updateStore()
	player_balance.updateBalance()
	$SidePanel/Inventory.updateInventory()
	refreshExercisePanels()
	setActiveExerciseUI()
	Globals.saveGame()


func _on_Store_experience_purchase_made(muscle):
	player_balance.updateBalance()
	experiencePurchased(muscle)
	Globals.saveGame()


func _on_SidePanel_clicked_challenges():
	
	if $Store.is_visible_in_tree():
		last_interface = $Store
		$Store.hide()
	
	if $ExerciseSelect.is_visible_in_tree():
		last_interface = $ExerciseSelect
		$ExerciseSelect.hide()
	
	$ChallengesDisplay.show()


func _on_ChallengesDisplay_clicked_return():
	
	last_interface.show()
	$ChallengesDisplay.hide()


func _on_Settings_setting_changed(setting, is_on):
	
	match setting:
		"Strength XP":
			show_strength = is_on
		"Proficiency XP":
			show_proficiency = is_on
		"Money":
			show_money = is_on
	
	Globals.saveGame()


func _on_SidePanel_show_settings():
	$Settings.show()


func supplement_taken(num, type):
	
	setActiveExerciseUI()
	
	$PopupManager.createPopup(Globals.supplement_icons[type], Globals.formatBigNumber(num) + " charges")
