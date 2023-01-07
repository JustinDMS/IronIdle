extends Control

func _ready():
	updateBalance()

func updateBalance():
	$HBoxContainer/Label_Money.set_text(str("%.2f" % Globals.player.money))
