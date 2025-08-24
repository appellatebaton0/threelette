extends DamageComponent
class_name BasicDamageComponent

@export var damage:float = 12.0

func while_on_target(_delta:float):
	get_health_component().take_damage(damage)
	queue_free()
