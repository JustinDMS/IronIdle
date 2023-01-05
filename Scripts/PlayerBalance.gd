extends Control

var money

func _ready():
	updateBalance()

func _process(_delta):
	updateBalance()

func updateBalance():
	$HBoxContainer/Label_Money.set_text(str("%.2f" % Globals.money))
