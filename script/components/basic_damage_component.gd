extends DamageComponent
class_name BasicDamageComponent

func randomize_values():
	damage = floor(randf_range(1, 20) * 10) / 10
func component_effect() -> String:
	return "+" + str(damage) + " Damage"

@export var damage:float = 12.0

func while_on_target(_delta:float):
	if target.get_health_component() != null and actor != null:
		target.get_health_component().take_damage(damage, source)
		if kill_actor:
			actor.queue_free()
		else:
			queue_free()
