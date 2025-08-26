extends Node2D
class_name Component

@export var actor:Actor

## Runs once the actor is fully situated
func _once_ready() -> void:
	pass
func _ready() -> void:
	if actor == null and get_parent() is Actor:
		actor = get_parent()
	_once_ready()

func get_me():
	return self
