extends Node2D

@onready var sprite = $Sprite2D

var suit := ""
var rank := ""

func set_card(rank: String, suit: String):
	self.rank = rank
	self.suit = suit
	var card_code = suit + '_' + rank
	sprite.texture = load("res://assets/cards/card_%s.png" % card_code)
