extends Control


func createPopup(texture, text : String):
	
	var scene = load("res://Scenes/Popup.tscn")
	var instance = scene.instance()
	
	instance.initPopup(texture, text)
	$VBoxContainer.add_child(instance)
