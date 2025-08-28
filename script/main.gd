extends Node
class_name Main

signal reset

@onready var world:Node2D = $World
@onready var player:Actor = get_tree().get_first_node_in_group("Player")
@onready var camera:Camera = get_tree().get_first_node_in_group("Camera")

@onready var spawnpoint_options:Array[Vector2] = get_spawnpoint_options()
func get_spawnpoint_options() -> Array[Vector2]:
	
	var options:Array[Vector2]
	
	for child in $World/PlayerSpawnOptions.get_children():
		if child is Node2D:
			options.append(child.global_position)
	
	return options
	

func _ready() -> void:
	reset.connect(_on_reset)

func _on_reset():
	player.global_position = spawnpoint_options.pick_random()
	camera.global_position = player.global_position
