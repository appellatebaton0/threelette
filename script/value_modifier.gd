extends Resource
class_name ValueModifier

enum MOD_TYPES{MULTIPLY, ADD}
@export var mod_type:MOD_TYPES = MOD_TYPES.MULTIPLY
@export var modifier:float = 1.0

var next_modifier:ValueModifier

func get_end() -> ValueModifier:
	if next_modifier == null:
		return self
	return next_modifier.get_end()

func append(new_modifier:ValueModifier) -> bool:
	if get_end().next_modifier == null:
		get_end().next_modifier = new_modifier
		return true
	else:
		return false

func modify_value(value:float) -> float:
	if next_modifier != null:
		value = next_modifier.modify_value(value)
	
	if mod_type == MOD_TYPES.MULTIPLY:
		value *= modifier
	elif mod_type == MOD_TYPES.ADD:
		value += modifier
	
	return value
