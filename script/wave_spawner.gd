extends Node2D
class_name WaveSpawner

signal round_started
signal round_complete

signal start_round

var round_running:bool = false
var round_num:int = 1

@onready var spawnpoints:Array[Vector2] = get_spawnpoints()
func get_spawnpoints() -> Array[Vector2]:
	var spawnpoints:Array[Vector2]
	
	for child in get_children():
		if child is Node2D:
			spawnpoints.append(child.global_position)
	
	return spawnpoints

@export var enemy_options:Array[ConditionalEnemyOption]

func get_enemy_options() -> Array[PackedScene]:
	var options:Array[PackedScene]
	
	return options

func spawn_enemy_at(position:Vector2):
	
	var new:Actor = get_enemy_options().pick_random().instantiate()
	
	new.global_position = position
	
	new.get_motion_component().randomize_values()
	new.get_health_component().randomize_values()
	
	add_sibling(new)
	
	return new

func spawn_round(round_number:int):
	var spawn_options = spawnpoints.duplicate()
	
	for i in range(round_number):
		if len(spawn_options) <= 0:
			spawn_options = spawnpoints.duplicate()
		
		var spawn_at = spawnpoints.pick_random()
		spawn_enemy_at(spawn_at)
		
		spawn_options.erase(spawn_at)
		
	round_started.emit()
	round_running = true
	

func _process(delta: float) -> void:
	if len(get_tree().get_nodes_in_group("Ghost")) <= 0 and round_running:
		round_running = false
		round_num += 1
		round_complete.emit()
		


func _on_upgrade_selected() -> void:
	start_round.emit()
func _on_start_round() -> void:
	spawn_round(round_num)


func _on_main_reset() -> void:
	for ghost in get_tree().get_nodes_in_group("Ghost"):
		if ghost is Actor:
			ghost.get_health_component().take_damage(20000, ghost)
	round_running = false
	round_num = 1
	round_complete.emit()
	
