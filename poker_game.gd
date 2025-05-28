extends Node2D

const RANKS = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "J", "Q", "K", "A"]
const SUITS = ["clubs", "diamonds", "hearts", "spades"]

@export var card_scene: PackedScene

func _ready():
	var spacing = 100
	for i in range(5): # Mostrar 5 cartas aleatorias
		var rank = RANKS[randi() % RANKS.size()]
		var suit = SUITS[randi() % SUITS.size()]
		var card = card_scene.instantiate()
		add_child(card)
		card.position = Vector2(100 + spacing * i, 200)
		card.set_card(rank, suit)
