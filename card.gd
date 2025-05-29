extends Node2D

@onready var sprite = $Sprite2D

var suit := ""
var rank := ""

var dragging := false
var offset := Vector2.ZERO
var original_z_index := 0
var locked := false

func set_card(rank_: String, suit_: String):
	rank = rank_
	suit = suit_
	var card_code = suit + '_' + rank
	sprite.texture = load("res://assets/cards/card_%s.png" % card_code)

func _input(event):
	if locked:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and _is_mouse_over():
				dragging = true
				offset = global_position - event.position
				original_z_index = z_index
				z_index = 100  # Eleva esta carta sobre las demás
				get_viewport().set_input_as_handled()
			elif not event.pressed:
				dragging = false
				z_index = original_z_index
				try_snap_to_slot()

	elif event is InputEventMouseMotion and dragging:
		global_position = event.position + offset

# Busca slot cercano
func try_snap_to_slot():
	var space_state = get_world_2d().direct_space_state

	var query = PhysicsPointQueryParameters2D.new()
	query.position = global_position
	query.collide_with_areas = true
	query.collide_with_bodies = false

	var result = space_state.intersect_point(query, 32)

	for item in result:
		var collider = item.collider
		if collider is Area2D and collider.has_method("can_accept_card") and collider.can_accept_card(self):
			collider.place_card(self)
			return


# Detecta si el mouse está sobre el sprite (colisión visual simple)
func _is_mouse_over() -> bool:
	var local_mouse_pos = to_local(get_viewport().get_mouse_position())
	return sprite.get_rect().has_point(local_mouse_pos)
