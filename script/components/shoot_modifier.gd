extends Component
class_name ShootModifier

@export var modifier:ValueModifier = ValueModifier.new()

func randomize_values():
	modifier.modifier = randi_range(90, 98) / 100.0

func component_effect() -> String:
	return "+" + str(floor(1000 * (1 - modifier.modifier)) / 10) + " Fire Rate"

func _process(_delta: float) -> void:
	if actor != null:
		print("freed ", self)
		var shoot_component:ShootComponent = actor.get_shoot_component()
		if shoot_component.fire_rate_modifier != null:
			shoot_component.fire_rate_modifier.append(modifier.duplicate())
		else:
			shoot_component.fire_rate_modifier = modifier.duplicate()
		queue_free()
