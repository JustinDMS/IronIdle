extends Control

var button
var selected_challenge
var progress

func setDetails(challenge):
	
	selected_challenge = challenge
	$MarginContainer/VBoxContainer/Label_Name.set_text(challenge._name)
	$MarginContainer/VBoxContainer/VBoxContainer/Label_Description.set_text(challenge.description)
	$MarginContainer/VBoxContainer/VBoxContainer/VBox_Reward/Label_Reward.set_text(challenge.reward)
	
	if challenge.is_tracked:
		setProgressBar()
		determineCanClaim(challenge)
	else:
		for i in $MarginContainer/VBoxContainer/VBoxContainer/VBox_Progress.get_children():
			i.queue_free()
		determineCanClaim(challenge)


func determineCanClaim(challenge):
	if Globals.player.challenge_progress[challenge._name] == true:
		return
	var is_unlocked = Globals.getCanClaimChallenge(challenge._name)
	$MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_disabled(not is_unlocked)


func getChallengeMaxValue():
	match selected_challenge.series_position:
		1: return 1000
		2: return 2500
		3: return 5000


func getChallengeCurrentValue():
	match selected_challenge.series_name:
		"Need a Boost":
			return Globals.player.supplements_used["Caffeine"]
		"Gain Train":
			return Globals.player.supplements_used["Creatine"]
		"Focus on Form":
			return Globals.player.supplements_used["BCAA"]


func setProgressBar():
	progress = $MarginContainer/VBoxContainer/VBoxContainer/VBox_Progress/ProgressBar
	var max_value = getChallengeMaxValue()
	progress.set_max(max_value)
	updateProgressBar()


func updateProgressBar():
	if selected_challenge.is_tracked:
		progress.set_value(getChallengeCurrentValue())


func _on_Button_Claim_pressed():
	
	$MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_disabled(true)
	$MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Button_Claim.set_text("Claimed!")
	Globals.claimChallenge(selected_challenge)
