extends Component
class_name TrailComponent

var me:Line2D = get_me()

@onready var motion_component:MotionComponent = actor.get_motion_component()

@export var trail_segments:int = 2
@export_range(0.0, 1.0, 0.05) var lerp_weight:float = 0.0

var trail:Line2D

func get_follow_point() -> Vector2:
	return actor.global_position

func add_points(amount:int):
	if amount <= 0:
		return
	
	me.add_point(Vector2(randi_range(-10,10), randi_range(-10,10)))
	
	add_points(amount - 1)
 
func _ready() -> void:
	add_points(trail_segments)

func _process(delta: float) -> void:
	for i in me.get_point_count():
		# print(to_local(followee.global_position))
		if i == 0:
			me.set_point_position(i, Vector2.ZERO)
		else:
			me.set_point_position(i, lerp(me.get_point_position(i), me.get_point_position(i - 1) - (motion_component.velocity * 0.05), lerp_weight))
			#to_local(lerp(to_global(me.get_point_position(i)), to_global(me.get_point_position(i - 1)), lerp_weight))
