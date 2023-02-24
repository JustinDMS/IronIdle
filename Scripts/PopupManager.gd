extends Control


func createPopup(texture, text : String):
	
	var scene = load("res://Scenes/Popup.tscn")
	var instance = scene.instance()
	
	instance.initPopup(texture, text)
	$VBox_Bottom.add_child(instance)


func createBigPopup(texture, text : String, is_strength : bool, exercise_name):
	
	var scene = load("res://Scenes/LevelUpPopup.tscn")
	var instance = scene.instance()
	
	instance.initPopup(texture, text, is_strength, exercise_name)
	$VBox_Top.add_child(instance)
