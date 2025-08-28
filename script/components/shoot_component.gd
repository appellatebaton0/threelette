extends Component
class_name ShootComponent

@export var fire_rate = 0.6
var fire_delay = 0.0

@export var fire_rate_modifier:ValueModifier

@export var aim_assist:bool = true
@export var aim_assist_threshold:float = 200.0

@onready var camera:Camera = get_tree().get_first_node_in_group("Camera")
@onready var me:Node2D = get_me()

@onready var look_point:Vector2 = get_mouse_position()

@onready var offset = me.position.distance_to(Vector2.ZERO)

@onready var bullet_scene:PackedScene = load("res://scene/bullet.tscn")
@onready var main:Main = get_tree().get_first_node_in_group("Main")

func fire_bullet():
	var bullet:Actor = bullet_scene.instantiate()
	
	for child in actor.get_children():
		if child is DamageComponent:
			var new:DamageComponent = child.duplicate()
			bullet.add_child(new)
			new.kill_actor = true
			new.actor = bullet
			
	
	for damage_component in bullet.get_damage_components():
		damage_component.source = actor
	
	bullet.global_position = $Indicator.global_position
	main.world.add_child(bullet)
	
	bullet.get_motion_component().direction = me.global_position.direction_to(get_mouse_position())

func get_mouse_position() -> Vector2:
	var mouse_offset = (get_viewport().get_mouse_position() - (me.get_viewport_rect().size / 2)) / camera.zoom
	
	var mouse_position = (camera.global_position + mouse_offset)
	
	if aim_assist:
		var closest_ghost:Actor
		var closest_dist:float = 10000
		for ghost in get_tree().get_nodes_in_group("Ghost"):
			if ghost is Actor:
				if mouse_position.distance_to(ghost.global_position) < aim_assist_threshold and mouse_position.distance_to(ghost.global_position) < closest_dist:
					closest_ghost = ghost
					closest_dist = mouse_position.distance_to(ghost.global_position)
		if closest_ghost != null:
			mouse_position = closest_ghost.global_position + closest_ghost.get_motion_component().velocity
	
	return mouse_position

func _ready() -> void:
	me.position = Vector2.ZERO
	$Indicator.position = Vector2(offset, 0)

func _process(delta: float) -> void:
	
	if fire_delay <= 0:
		fire_bullet()
		fire_delay = fire_rate_modifier.modify_value(fire_rate) if fire_rate_modifier != null else fire_rate
	
	me.look_at(get_mouse_position())
	fire_delay = move_toward(fire_delay, 0 , delta)
