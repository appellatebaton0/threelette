extends Component
class_name HealthComponent

signal health_reached_zero
signal took_damage

@export var max:float = 50.0
@export var health:float = 50.0

@export var die_on_health_zero:bool = false

func take_damage(amount:float, from:Actor, knockback:float = 130.0):
	if amount < 0:
		return
	
	health = maxf(health - amount, 0.0)
	
	took_damage.emit()
	if knockback > 0:
		actor.get_motion_component().velocity += from.global_position.direction_to(actor.global_position) * knockback
		# from.get_motion_component().velocity += actor.global_position.direction_to(from.global_position) * knockback
	
	if health <= 0.0:
		health_reached_zero.emit()

func _on_health_reached_zero():
	if die_on_health_zero:
		actor.queue_free()
