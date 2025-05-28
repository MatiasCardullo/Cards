extends Area2D

var occupied := false

# Usado para detectar si una carta se soltó encima
func can_accept_card() -> bool:
	return not occupied

func place_card(card: Node2D):
	occupied = true
	card.position = global_position
