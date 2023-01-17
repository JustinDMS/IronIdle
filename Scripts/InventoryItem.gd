extends Control

func addItem(item_name : String, array):
	
	$HBoxContainer/Label_Item.set_text(item_name)
	
	var count = array.count(item_name)
	$HBoxContainer/Label_Amount.set_text("x" + str(count))
