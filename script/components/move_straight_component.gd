extends MotionComponent
class_name MoveStraightComponent

@export var move_speed:float = 120.0

@export var velocity:Vector2

func _process(delta: float) -> void:
	actor.global_position += direction * move_speed * delta
