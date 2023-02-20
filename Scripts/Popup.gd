extends Control


func _ready():
	$Timer.start()
	$AnimationPlayer.play("Popup_Fade")


func initPopup(texture, text : String):
	$HBoxContainer/TextureRect_Type.set_texture(texture)
	$HBoxContainer/Label_TypeAmount.set_text(text)


func _on_Timer_timeout():
	queue_free()
