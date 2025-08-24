extends Component
class_name HealthComponent

signal health_reached_zero
signal took_damage

@export var max:float = 50.0
@export var health:float = 50.0

func take_damage(amount:float):
	
	if amount < 0:
		return
	
	health = maxf(health - amount, 0.0)
	
	took_damage.emit()
	
	if health <= 0.0:
		print("reached 0")
		health_reached_zero.emit()
