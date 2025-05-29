extends Area2D

@export_enum("hand", "field", "discard") var slot_type := "field"
var occupied := false

# Usado para detectar si una carta se soltó encima
func can_accept_card(card: Node2D) -> bool:
	return not occupied

func place_card(card: Node2D):
	occupied = true
	card.position = global_position
	card.locked = slot_type != "hand"
