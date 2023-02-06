extends Control

var button
var selected_challenge

func setDetails(challenge):
	
	selected_challenge = challenge
	$VBoxContainer/Label_Name.set_text(challenge._name)
	$VBoxContainer/VBoxContainer/Label_Description.set_text(challenge.description)
	$VBoxContainer/VBoxContainer/VBox_Reward/Label_Reward.set_text(challenge.reward)
	determineCanClaim(challenge)


func determineCanClaim(challenge):
	var is_unlocked = Globals.getCanClaimChallenge(challenge._name)
	$VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_disabled(not is_unlocked)


func _on_Button_Claim_pressed():
	
	$VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_disabled(true)
	$VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_text("Claimed!")
	Globals.claimChallenge(selected_challenge)
