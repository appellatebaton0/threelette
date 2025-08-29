extends Component
class_name ParticleComponent

var me:GPUParticles2D = get_me()

@export var collision_component:CollisionComponent
@export var play_on_hit:bool
@export var kill_on_hit:bool

@onready var main:Main = get_tree().get_first_node_in_group("Main")

func _ready() -> void:
	if collision_component != null:
		collision_component.hit_something.connect(_on_hit)

func _on_hit():
	if not kill_on_hit:
		reparent(main)
	if play_on_hit:
		me.emitting = true
