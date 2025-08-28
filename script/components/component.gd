extends Node2D
class_name Component

@export var persistent:bool = false
@export var actor:Actor

## Runs once the actor is fully situated
func _once_ready() -> void:
	pass
func _ready() -> void:
	if actor == null and get_parent() is Actor:
		actor = get_parent()
	var main:Main = get_tree().get_first_node_in_group("Main")
	main.reset.connect(_on_reset)
	_once_ready()

func get_me():
	return self

func randomize_values():
	pass
func component_effect() -> String:
	return ""

func _on_reset():
	if not persistent:
		queue_free()
