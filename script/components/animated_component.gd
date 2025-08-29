extends Component
class_name AnimatedComponent

var me:AnimatedSprite2D = get_me()

@export var flip_by_move_direction:bool = true

@onready var motion_component:MotionComponent = actor.get_motion_component()

func _process(_delta: float) -> void:
	if flip_by_move_direction:
		me.flip_h = motion_component.is_facing_left()
	
	me.play(motion_component.state)
