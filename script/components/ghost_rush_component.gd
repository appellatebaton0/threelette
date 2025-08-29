extends MotionComponent
class_name GhostRushComponent

var me:Node2D = get_me()

@onready var player:Actor = get_tree().get_first_node_in_group("Player")

@export var MOVEMENT_SPEED:float = 40.0
@export var MOVEMENT_RANGE:Vector2 = Vector2(25.0, 55.0)

@export var WOBBLE_HEIGHT:float = 30
@export var WOBBLE_WAVELENGTH:float = 10

var velocity:Vector2 = Vector2.ZERO

func randomize_values():
	MOVEMENT_SPEED = randf_range(MOVEMENT_RANGE.x, MOVEMENT_RANGE.y)
	

func is_facing_left():
	return velocity.x > 0

func _process(delta: float) -> void:
	if player != null:
		direction = actor.global_position.direction_to(player.global_position)
		
		if actor.global_position.distance_to(player.global_position) > 20:
			direction = me.global_position.direction_to(player.global_position + Vector2((WOBBLE_HEIGHT * (sin(me.global_position.y / WOBBLE_WAVELENGTH))), (WOBBLE_HEIGHT * (sin(me.global_position.x / WOBBLE_WAVELENGTH)))))
		
		var speed_additor:float = actor.global_position.distance_to(player.global_position) / 5
		var random_offset:float = 25 * randf()
		
		velocity += (direction * (MOVEMENT_SPEED + random_offset + max(0,speed_additor)))
		actor.global_position += (velocity * delta)
		velocity -= (direction * (MOVEMENT_SPEED + random_offset + max(0, speed_additor)))
		velocity /= 1.3


func _ready() -> void:
	var health_component:HealthComponent
	for child in get_children():
		if child is HealthComponent:
			health_component = child
	if health_component != null:
		health_component.health_reached_zero.connect(_on_death)

func _on_death():
	queue_free()
