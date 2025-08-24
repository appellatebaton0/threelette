extends Component
class_name ShootComponent

@export var fire_rate = 1.0
var fire_delay = 0.0

@onready var player:Player = get_parent()
@onready var camera:Camera = get_tree().get_first_node_in_group("Camera")
@onready var me:Node2D = get_me()
func get_me() -> Node2D:
	var me = self
	if me is Node2D:
		return me
	else:
		return null

@onready var look_point:Vector2 = get_mouse_position()

@onready var offset = me.position.distance_to(Vector2.ZERO)

@onready var bullet_scene:PackedScene = load("res://scene/bullet.tscn")
@onready var main:Main = get_tree().get_first_node_in_group("Main")
func fire_bullet():
	var bullet:Bullet = bullet_scene.instantiate()
	
	bullet.global_position = $Indicator.global_position
	main.world.add_child(bullet)
	
	bullet.initial_velocity = player.velocity
	bullet.fire_direction = me.global_position.direction_to(get_mouse_position())

func get_mouse_position() -> Vector2:
	var mouse_offset = (get_viewport().get_mouse_position() - (me.get_viewport_rect().size / 2)) / camera.zoom
	
	return (camera.global_position + mouse_offset)

func _ready() -> void:
	me.position = Vector2.ZERO
	$Indicator.position = Vector2(offset, 0)

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("Fire") and fire_delay <= 0:
		fire_bullet()
		fire_delay = fire_rate
	
	me.look_at(get_mouse_position())
	fire_delay = move_toward(fire_delay, 0 , delta)
