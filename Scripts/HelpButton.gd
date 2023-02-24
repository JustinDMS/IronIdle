extends Control


func _ready():
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)


func _on_Button_Help_pressed():
	$Panel.show()
	set_mouse_filter(Control.MOUSE_FILTER_STOP)
	$Button_Help.hide()
	$Button_Exit.show()


func _on_Button_Exit_pressed():
	$Panel.hide()
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$Button_Exit.hide()
	$Button_Help.show()
