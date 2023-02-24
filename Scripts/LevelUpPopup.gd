extends Control


func _ready():
	$Timer.start()
	$AnimationPlayer.play("Anim_LevelUpPopup_Fade")


func initPopup(texture, text : String, is_strength : bool, exercise_name):
	$VBoxContainer/HBoxContainer/TextureRect.set_texture(texture)
	$VBoxContainer/HBoxContainer/VBoxContainer/Label_Level.set_text(text)
	
	if is_strength:
		$VBoxContainer/HBoxContainer/VBoxContainer/Label_Exercise.queue_free()
	else:
		$VBoxContainer/HBoxContainer/VBoxContainer/Label_Exercise.set_text(exercise_name)


func _on_Timer_timeout():
	queue_free()
