extends DamageComponent
class_name BasicDamageComponent

@export var damage:float = 12.0

@export var kill_actor:bool = true

func while_on_target(_delta:float):
	if target.get_health_component() != null and actor != null:
		target.get_health_component().take_damage(damage, source)
		if kill_actor:
			actor.queue_free()
		else:
			queue_free()
