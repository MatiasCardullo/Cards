extends Node2D

@onready var sprite = $Sprite2D

var suit := ""
var rank := ""

var dragging := false
var offset := Vector2.ZERO

func set_card(rank_: String, suit_: String):
    rank = rank_
    suit = suit_
    var card_code = suit + '_' + rank
    sprite.texture = load("res://assets/cards/card_%s.png" % card_code)

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed and _is_mouse_over():
                dragging = true
                offset = global_position - event.position
                get_viewport().set_input_as_handled()
            elif not event.pressed:
                dragging = false

    elif event is InputEventMouseMotion and dragging:
        global_position = event.position + offset

# Detecta si el mouse está sobre el sprite (colisión visual simple)
func _is_mouse_over() -> bool:
    var local_mouse_pos = to_local(get_viewport().get_mouse_position())
    return sprite.get_rect().has_point(local_mouse_pos)

