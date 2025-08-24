extends Node2D
class_name Bullet

var fire_direction:Vector2
var initial_velocity:Vector2

const LIFETIME:float = 6.0
var life_left:float = LIFETIME

func _process(delta: float) -> void:
	global_position += initial_velocity * delta
	
	life_left = move_toward(life_left, 0, delta)
	if life_left == 0:
		queue_free()
