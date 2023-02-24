extends Control

func _ready():
	updateBalance()

func updateBalance():
	var text = str("%.2f" % Globals.player.money)
	var new_text = Globals.formatBigNumber(text)
	$HBoxContainer/Label_Money.set_text(new_text)
