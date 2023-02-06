extends Control

signal clicked_return


func _ready():
	hide()


func buildChallengeList():
	
	clearChallengeButtons()
	
	var challenges_container = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Challenges/VBox_Unclaimed
	var claimed_challenges_container = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Challenges/ScrollContainer/VBox_Claimed
	var scene = load("res://Scenes/ChallengeButton.tscn")
	var skip_series = []
	
	for i in Globals.all_challenges:
		
		var instance = scene.instance()
		
		if Globals.player.challenge_progress[i._name]: # Checks if challenge is already completed
			addButton(claimed_challenges_container, instance, i)
			instance.disableButton()
		
		elif i.is_series:
			
			if skip_series.has(i.series_name):
				continue
			
			elif i.series_position == 1:
				skip_series.append(i.series_name)
				addButton(challenges_container, instance, i)
			
			elif i.series_position == 2:
				skip_series.append(i.series_name)
				addButton(challenges_container, instance, i)
			
			elif i.series_position == 3:
				skip_series.append(i.series_name)
				addButton(challenges_container, instance, i)
			
			elif i.series_position == 4:
				skip_series.append(i.series_name)
				addButton(challenges_container, instance, i)
			
			elif i.series_position == 5:
				skip_series.append(i.series_name)
				addButton(challenges_container, instance, i)
			
		else: 
			print(i._name + " is not part of a series")
			addButton(challenges_container, instance, i)


func addButton(container, instance, item):
	instance.setButtonText(item._name)
	instance.button.connect("pressed", self, "displayChallenge", [item])
	container.add_child(instance)


func displayChallenge(i):
	
	clearDisplayedChallenge()
	
	var details_container = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Details
	var scene = load("res://Scenes/ChallengeDetails.tscn")
	var instance = scene.instance()
	
	instance.setDetails(i)
	details_container.add_child(instance)


func clearChallengeButtons():
	
	var challenges = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Challenges/VBox_Unclaimed
	var claimed_challenges = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Challenges/ScrollContainer/VBox_Claimed
	
	for n in challenges.get_children():
		n.queue_free()
	
	for n in claimed_challenges.get_children():
		n.queue_free()


func clearDisplayedChallenge():
	
	var details_container = $MarginContainer/VBoxContainer/HBoxContainer/VBox_Details
	
	for n in details_container.get_children():
		n.queue_free()


func _on_Button_Exit_pressed():
	clearDisplayedChallenge()
	hide()
	emit_signal("clicked_return")
