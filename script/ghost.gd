extends Area2D
class_name Ghost

@onready var player:Player = get_tree().get_first_node_in_group("Player")

const WOBBLE_HEIGHT:float = 14
const WOBBLE_WAVELENGTH:float = 2

func _process(delta: float) -> void:
	
	var direction = global_position.direction_to(player.global_position)
	
	if global_position.distance_to(player.global_position) > 20:
		direction = global_position.direction_to(player.global_position + Vector2((WOBBLE_HEIGHT * (sin(global_position.y / WOBBLE_WAVELENGTH))), (WOBBLE_HEIGHT * (sin(global_position.x / WOBBLE_WAVELENGTH)))))
	
	global_position += direction * delta * (10 + (25 * randf()))

func _ready() -> void:
	var health_component:HealthComponent
	for child in get_children():
		if child is HealthComponent:
			health_component = child
	if health_component != null:
		health_component.health_reached_zero.connect(_on_death)

func _on_death():
	queue_free()
	pass
