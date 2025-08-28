extends Component
class_name DamageComponent

signal damage_done

# Reparents to the target on hit and runs from there.

var target:Actor

var source:Actor

@export var kill_actor:bool = true

func _once_ready() -> void:
	if source == null:
		source = actor

func _process(delta: float) -> void:
	if target != null:
		while_on_target(delta)

func while_on_target(_delta:float):
	pass

func apply_to(target_actor:Actor):
	if target_actor == actor or target_actor == source:
		return false
		
	reparent(target_actor)
	target = target_actor
