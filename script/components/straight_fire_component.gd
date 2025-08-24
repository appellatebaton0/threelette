extends BulletComponent
class_name StraightFireComponent

@export var fire_speed:float = 120.0

func _process(delta: float) -> void:
	bullet.global_position += bullet.fire_direction * fire_speed * delta
