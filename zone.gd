extends Node2D

@export var zone_name: String = "Zona"
@export var slot_count: int = 5
@export var slot_scene: PackedScene

func _ready():
	$Label.text = zone_name

	var spacing = 100
	for i in range(slot_count):
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.position = Vector2(i * spacing, 30)

		# Asignar tipo de slot según el nombre de la zona
		match zone_name.to_lower():
			"mano":
				slot.slot_type = "hand"
			"campo":
				slot.slot_type = "field"
			"descarte":
				slot.slot_type = "discard"
			_:
				slot.slot_type = "field"  # valor por defecto
