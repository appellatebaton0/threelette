extends Node2D
class_name WaveSpawner

signal round_started

@onready var spawnpoints:Array[Vector2] = get_spawnpoints()
func get_spawnpoints() -> Array[Vector2]:
	var spawnpoints:Array[Vector2]
	
	for child in get_children():
		if child is Node2D:
			spawnpoints.append(child.global_position)
	
	return spawnpoints

var enemy_options:Array[PackedScene] = [load("res://scene/ghost.tscn")]

func spawn_enemy_at(position:Vector2):
	var new:Ghost = enemy_options.pick_random().instantiate()
	
	new.global_position = position
	add_sibling(new)
	
	return new

func spawn_round(round_number:int):
	var spawn_options = spawnpoints.duplicate()
	
	for i in range(round_number):
		if len(spawn_options) <= 0:
			print(spawn_options)
			spawn_options = spawnpoints.duplicate()
		
		var spawn_at = spawnpoints.pick_random()
		spawn_enemy_at(spawn_at)
		
		spawn_options.erase(spawn_at)
		
	round_started.emit()

var e = false
func _process(delta: float) -> void:
	if not e:
		spawn_round(5)
		e = true
