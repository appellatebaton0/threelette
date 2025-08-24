extends Node2D
class_name Bullet

var fire_direction:Vector2
var initial_velocity:Vector2

func _process(delta: float) -> void:
	global_position += initial_velocity * delta
